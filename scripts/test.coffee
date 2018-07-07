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
  robot.on 'test', (test) ->
  robot.send "id = #{test.id}"
  return
