# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   None
#
# Author:
#   belldavidr

module.exports = (robot) ->
  robot.on 'test_brief', (test_brief) ->
  robot.send "#{test_brief.user}"
  return
