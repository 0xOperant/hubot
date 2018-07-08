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
    match = /^\@jarvis+/i.test(res.message.text) or /^\jarvis+/i.test(res.message.text)
    if match 
      res.reply "I don't yet know the command: `#{res.message.text}`\nPlease try `@jarvis help` or `@jarvis help <command>` for command/syntax help.\nYou can also request this function by github Pull Request."
