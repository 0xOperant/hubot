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
    id = res.message.user.id
    res.reply "here is your briefing:"
    robot.emit 'test_brief', {
      user: id
    }
