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
  robot.respond /wigle (?:check) (.*)/i, (res) ->
    ssid = res.match[1]
    url = "https://api.wigle.net/api/v2/network/search?onlymine=false&freenet=false&paynet=false&ssid=#{ssid}"
    url.headers Authorization: "Basic #{auth}"
    robot.http(url).get() (err, response, body) ->
      if err
        res.send ":disappointed: Encountered an error while searching wigle.net: #{err}"
        return
      else
        api = JSON.parse(body)
        for entry of api.results
          trilat = api.results.trilat
          trilong = api.resilts.trilong
          ssid = api.results.ssid
          lastupdt = api.results.lastupdt
          road = api.results.road
          city = api.results.city
          region = api.results.region
          country = api.results.country
          encryption = api.results.encryption
          res.send "SSID #{ssid} seen at #{road} #{city}, #{region} on #{lastupdt}, using #{encryption} encryption."
