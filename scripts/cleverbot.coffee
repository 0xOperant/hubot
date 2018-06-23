# Description:
#   Turns your bot into a snarky little shit
#
# Dependencies:
#   "cleverbot-node": "~0.3"
#
# Configuration:
#   CLEVERBOTIO_API_USER
#   CLEVERBOTIO_API_KEY
#
# Commands:
#   hubot #! <input> (chat via cleverbot.io api)
#
# Author:
#   operant

USER = process.env.CLEVERBOTIO_API_USER
KEY = process.env.CLEVERBOTIO_API_KEY

module.exports = (robot) ->
  cleverbot = require("cleverbot.io")
  bot = new cleverbot(USER, KEY);

  robot.respond /#! (.*)/i, (msg) ->
    data = msg.match[1].trim()
    cleverbot.write(data, (response) => msg.send(response.output))
