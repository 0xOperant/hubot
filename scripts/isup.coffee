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
      res.send "response = #{response}"
      results = JSON.parse response
      res.send "results = #{results}"
#       if response.status_code is 1
#         res.send "`#{results.domain}` looks *up* from here."
#       else
#         res.send "`#{results.domain}` looks *down* from here."
