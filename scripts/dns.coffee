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
    if type is undefined
      res.send "You need to specify a server type (MX, for example)"
    host = escape(res.match[2]).slice(9)
    if host is undefined
      res.send "You need to specify a host (gmail.com, for example)"
    url = "https://dns-api.org/#{type}/#{host}"
    robot.http(url).get() (err, response, body) ->
      if response.statusCode isnt 200
        res.send ":rick: T-t-t-that didn't *buuurrrp* work, broh."
        return
      else
        api = JSON.parse body
        for entry of api
          name = api[entry].name
          ttl = api[entry].ttl
          type = api[entry].type
          value = api[entry].value
          res.send "#{name} = #{value}"
