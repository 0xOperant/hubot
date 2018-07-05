# Description:
#  SSLabs for Hubot
#
# Dependencies:
#  None
#
# Configuration:
#  None
#
# Commands:
#  hubot *ssl check `domain`* - Check SSL certificate at `domain`
#
# Author
#  belldavidr

module.exports = (robot) ->

  analyze = robot.http(url).get() (err, response, body) ->
    url = "https://api.ssllabs.com/api/v3/analyze?host=#{host}&fromCache=on&maxAge=730&all=done"
    robot.http(url).get() (err, response, body) ->

  sleep = (ms) ->

  robot.respond /ssl (?:check) (.+)/i, (res) ->
    host = res.match[1].slice(7)
    res.reply "Scanning #{host} with Qualys SSL Labs..."
    analyze
    if err
      res.reply ":rick: T-t-t-that didn't *buuurrrp* work, broh."
      return
    else
      api = JSON.parse body
      until api.status is "READY"
        res.send "#{server} status: #{status}..."
        await sleep 10000
        analyze
      for endpoint of api.host.endpoints
        grade = api.host[endpoint].grade
        ip = api.host[endpoint].ipAddress
        server = api.host[endpoint].serverName
        res.send "Grade: #{grade} for #{server} (#{ip}) \n"
      res.reply "Details are available at:\n #{url}"
    return
