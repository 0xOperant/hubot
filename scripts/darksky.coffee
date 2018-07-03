# Description
#   Grabs the current forecast from Dark Sky
#
# Dependencies
#   None
#
# Configuration
#   HUBOT_DARK_SKY_API_KEY
#   HUBOT_DARK_SKY_DEFAULT_LOCATION
#   HUBOT_DARK_SKY_UNITS (optional - us, si, ca, or uk)
#
# Commands:
#   hubot *weather* - get the weather for default location `23322`
#   hubot *weather `location`* - get the weather for `location`
#
# Notes:
#   If HUBOT_DARK_SKY_DEFAULT_LOCATION is blank, weather commands without a location will be ignored
#
# Author:
#   kyleslattery
module.exports = (robot) ->

  robot.respond /weather ?(.+)?/i, (msg) ->
    location = msg.match[1] || process.env.HUBOT_DARK_SKY_DEFAULT_LOCATION
    return if not location

    googleurl = "http://maps.googleapis.com/maps/api/geocode/json"
    q = sensor: false, address: location
    msg.http(googleurl)
      .query(q)
      .get() (err, res, body) ->
        result = JSON.parse(body)

        if result.results.length > 0
          lat = result.results[0].geometry.location.lat
          lng = result.results[0].geometry.location.lng
          darkSkyMe msg, lat,lng , (darkSkyText) ->
            response = "Weather for #{result.results[0].formatted_address}\n. #{darkSkyText}"
            msg.send response
        else
          msg.send "Couldn't find #{location}"

darkSkyMe = (msg, lat, lng, cb) ->
  url = "https://api.forecast.io/forecast/#{process.env.HUBOT_DARK_SKY_API_KEY}/#{lat},#{lng}/"
  if process.env.HUBOT_DARK_SKY_UNITS
    url += "?units=#{process.env.HUBOT_DARK_SKY_UNITS}"
  msg.http(url)
    .get() (err, res, body) ->
      result = JSON.parse(body)

      if result.error
        cb ":rick: T-t-t-that didn't *buuurrrp* work, broh. #{result.error}"
        return

      isFahrenheit = process.env.HUBOT_DARK_SKY_UNITS == "us"
      if isFahrenheit
        fahrenheit = result.currently.temperature
        celsius = (fahrenheit - 32) * (5 / 9)
      else
        celsius = result.currently.temperature
        fahrenheit = celsius * (9 / 5) + 32
      humidity = result.currently.humidity * 100
      precip = result.currently.precipProbability * 100
      response = "Currently: #{result.currently.summary} (#{fahrenheit}°F "
      response += "with #{humidity}% humidity and #{precip}% chance of precipitation).\n"
      response += "Today: #{result.hourly.summary}\n"
      response += "Coming week: #{result.daily.summary}"
      cb response
