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
    robot.http(url)
      .header('User-Agent', 'Hubot')
      .get() (err, res, body) ->
        if
          err res.send "err: #{err}"
        else
          response = JSON.parse body
          res.send "response = #{response}"
          if response.status_code is 1
            res.send "#{response.domain} looks UP from here."
          else
            res.send "#{response.domain} looks DOWN from here."
