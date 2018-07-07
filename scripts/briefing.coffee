# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot *brief me `location`* - get weather for `location`, top headlines, and tracked shipments
#
# Author:
#   belldavidr

module.exports = (robot) ->
  robot.respond /brief me (.*)?/i, (res) ->
    zip = res.match[1]
    res.reply "here is your briefing:"
    robot.emit "weather", {user: res.message.user.id, location: zip}
    robot.emit "tracking", {user: res.message.user.id}
    robot.emit "news", {user: res.message.user.id}
