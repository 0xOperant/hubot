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
    host = escape(res.match[2]).slice(9)
    url = "https://dns-api.org/#{type}/#{host}"
    robot.http(url).get() (err, response, body) ->
      if response.statusCode isnt 200
        res.send ":rick: T-t-t-that didn't *buuurrrp* work, broh."
        return
      else
        api = JSON.parse body
        for entry of api
          name = api[entry].name
          type = api[entry].type
          value = api[entry].value
          msg = {
            "attachments": [
              {
                "fallback": "#{name} #{type} #{value}",
                "color": "#36a64f",
		"author_name": "DNS API",
		"author_link": "https://dns-api.org/",
                "title": "#{type} records for #{host}",
                "title_link": "#{url}",
                "fields": [
                  {
                    "title": "#{name}:",
                    "value": "#{type} records for #{host} = #{value}",
                    "short": false
                  }
                ]
		"image_url": "https://pbs.twimg.com/profile_images/930498210812088320/jWwRw-Yt_400x400.jpg"
		"thumb_url": "https://pbs.twimg.com/profile_images/930498210812088320/jWwRw-Yt_400x400.jpg"
		"footer": "dns-api.org"
              }
            ]
          }
          res.send msg
