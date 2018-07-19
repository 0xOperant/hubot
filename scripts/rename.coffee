# Description:
#   Tell people hubot's new name if they use the old one
#
# Commands:
#   None
#
module.exports = (robot) ->
  robot.hear /^@jarvis? (.+)/i, (res) ->
    response = "Jarvis? I had to kill him. He was a good guy. I'm #{robot.name}"
    response += " or #{robot.alias}" if robot.alias
    res.reply response
    return
