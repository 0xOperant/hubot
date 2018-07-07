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
  robot.on 'test', (id) ->
  robot.send "id = #{test.id}"
  return
