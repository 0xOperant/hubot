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
    zip = res.match[1] or 2332
    id = res.message.user.id
    res.reply "here is your briefing:"
    robot.emit 'weather', {user: id, location: zip}
    robot.emit 'shipment', {user: id}
    robot.emit 'news', {user: id}
