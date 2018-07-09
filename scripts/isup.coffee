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
    domain = res.match[1].slice(7)
    url = "http://isitup.org/#{domain}.json"
    robot.http(url).get() (err, response, body) ->
      if response.statusCode isnt 200
        res.send ":rick: T-t-t-that didn't *buuurrrp* work, broh."
        return
      else
        response = JSON.parse(body)
        if response.status_code is 1
          res.send "`#{response.domain}` looks *up* from here."
          else if response.status_code is 2
            res.send "`#{response.domain}` looks *down* from here."
            else response.status_code is 3
              res.send "Are you sure `#{response.domain}` is a valid domain?"
