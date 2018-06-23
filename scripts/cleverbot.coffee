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
#   hubot clever <input> (chat via cleverbot.io api)
#
# Author:
#   operant

USER = process.env.CLEVERBOTIO_API_USER
KEY = process.env.CLEVERBOTIO_API_KEY

Cleverbot = require('cleverbot.io')

module.exports = (robot) ->
  robot.respond /clever (.*)/i, (msg) ->
    query = msg.match[1].trim()
    bot = new Cleverbot(USER, KEY)
    callback = (response) ->
      msg.send response.message
    bot.write(query, callback)
