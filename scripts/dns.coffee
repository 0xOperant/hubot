# Description:
#   DNS lookups via dns-api.org
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot *nslookup `type` `host`* - type = server type (MX, etc), host= IP address (IPv4 and 6)
#
# Author:
#   belldavidr

module.exports = (robot) ->
  robot.respond /nslookup (.*) (.*)/i, (res) ->
    type = escape(res.match[1])
    res.send "type = #{type}"
    host = escape(res.match[2])
    res.send "host = #{host}"
    url = "https://dns-api.org/#{type}/#{host}"
    robot.http(url).get() (err, response, body) ->
      if response.statusCode isnt 200
        res.send ":rick: T-t-t-that didn't *buuurrrp* work, broh."
        return
      else
        api = JSON.parse body
        for result in api.body
          name = api.result.name
          value = api.result.value
          res.send "#{name} = #{value}"
