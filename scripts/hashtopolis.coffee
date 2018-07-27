# Description
#  Provides an incoming webhook for alerts from hashtopolis 
#
# Dependencies
#  None
#
# Configuration
#  Set the HUBOT_HASHTOPOLIS environment variable to authenticate incoming POSTS
#
# Commands
#  None
#
# Author
#  0xOperant


module.exports = (robot) ->
  robot.router.post '/hubot/chatsecrets/:room', (req, res) ->
    room   = req.params.room
    data   = if req.body.payload? then JSON.parse req.body.payload else req.body
    text   = data.text
    token  = data.token
    key    = process.env.HUBOT_HASHTOPOLIS

    if token is key
      robot.messageRoom room, "#{text}"
      res.send '200 OK'
    else
      robot.messageRoom room, ":rotating_light: *UNAUTHORIZED POSTING ATTEMPT VIA HASHTOPOLIS WEBHOOK* :rotating_light:"
      res.send '401 UNAUTHORIZED'
