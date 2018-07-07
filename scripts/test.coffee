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
  robot.on "test_brief", (test_brief) ->
  test_brief.send "it worked"
  return
