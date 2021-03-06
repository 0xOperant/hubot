# Description:
#  Queries the wigle.net api(v2) for the specified ssid
#
# Dependencies
#  None
#
# Configuration:
#  WIGLE_API_AUTH from api.wigle.net (user account required)
#
# Commands:
#  hubot *wigle check `ssid`* - Queries the wigle.net api for the specified `ssid`
#
# Author:
#   belldavidr

auth = process.env.WIGLE_API_AUTH

module.exports = (robot) ->
  robot.respond /wigle (?:check) (.+)/i, (res) ->
    query = res.match[1]
    url = "https://api.wigle.net/api/v2/network/search?onlymine=false&freenet=false&paynet=false&ssid=#{query}"
    robot.http(url)
    .headers Authorization: "Basic #{auth}"
    .get() (err, response, body) ->
      if err
        res.send ":rick: T-t-t-that didn't *buuurrrp* work, broh. #{err}"
        return
      else
        api = JSON.parse(body)
        if api.success is false
          res.send "We've hit our API limit for today. :disappointed:"
        else if api.totalResults > "0"
          res.send "Total results: *#{api.totalResults}.* Displaying US results only."
          for entry of api.results
            ssid = api.results[entry].ssid
            lastupdt = api.results[entry].lastupdt
            road = api.results[entry].road
            city = api.results[entry].city
            region = api.results[entry].region
            country = api.results[entry].country
            encryption = api.results[entry].encryption
            if country is "US"
              res.send "SSID #{ssid} last seen at #{road} in #{city}, #{region} on #{lastupdt}, using #{encryption} encryption."
        else
          res.send ":disappointed: SSID #{query} not found on wigle.net. "
