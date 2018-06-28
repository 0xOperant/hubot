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
    robot.http(url)
    .headers Authorization: "Basic #{auth}"
    .get() (err, response, body) ->
      if err
        res.send ":disappointed: Encountered an error while searching wigle.net: #{err}"
        return
      else
        api = JSON.parse(body)
        for entry of api.results
          ssid = ssid
          lastupdt = lastupdt
          city = city
          region = region
          country = country
          encryption = encryption
          res.send "SSID #{ssid} seen at #{road} #{city}, #{region} on #{lastupdt}, using #{encryption} encryption."
