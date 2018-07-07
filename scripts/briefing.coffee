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
  robot.respond /brief me/i, (res) ->
    res.reply "here is your briefing:"
    robot.emit 'test_brief', {
      user: res.message.user.id
      room: res.message.room
      res: res
    }
