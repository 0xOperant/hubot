# Description:
#  catchall to point users to the help cruft
#
# Dependencies:
#  None
#
# Commands:
#  None

module.exports = (robot) ->
  robot.catchAll (res) ->
    match = /^\@Hubot+/i.test(msg.message.text) or /^\Hubot+/i.test(msg.message.text)
    if match 
      res.send "I don't understand the command: `#{msg.message.text}` yet.\nPlease try `@jarvis help` or `@jarvis help <command>` for command/syntax help."
