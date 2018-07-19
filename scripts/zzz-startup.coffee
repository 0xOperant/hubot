# Description
#   A Hubot script that tells sends a message on startup.
#
# Configuration:
#   None
#
# Commands:
#   None
#
# Author:
#   belldavidr
#
module.exports = (robot) ->
  ROOM = "#daves_bots"
  MESSAGE = "*#{robot.name} is online* :robot_face:"

  robot.messageRoom ROOM, MESSAGE
