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

test_brief = {}

module.exports = (robot) ->
  robot.on 'test_brief', (test_brief) ->
  robot.send test_brief.user "it worked"
  return
