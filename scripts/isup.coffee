# Description:
#   Uses downforeveryoneorjustme.com to check if a site is up
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot *is `domain` up?* - Checks if `domain` is up
#
# Author:
#   belldavidr

module.exports = (robot) ->
  robot.respond /is (.*?) (up|down)(\?)?/i, (res) ->
    domain = escape(res.match[1]).slice(9)
    res.send "domain = #{domain}"
    url = "http://isitup.org/#{domain}.json"
    res.send "url = #{url}"
    robot.http(url).get() (err, response, body) ->
      res.send "body = #{body}"
#      response = JSON.parse(body)
#      if response.status_code is 1
#        res.send "`#{response.domain}` looks *up* from here."
#      else
#        res.send "`#{response.domain}` looks *down* from here."
