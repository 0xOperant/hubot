# Description
#  Provides an incoming webhook for alerts from the Wifi User Detection System (https://github.com/belldavidr/wuds)
#
# Dependencies
#  None
#
# Configuration
#  Set the WUDS_TOKEN environment variable to authenticate incoming POSTS
#
# Commands
#  None
#
# Author
#  belldavidr


module.exports = (robot) ->
  robot.router.post '/hubot/chatsecrets/:room', (req, res) ->
    room   = req.params.room
    data   = if req.body.payload? then JSON.parse req.body.payload else req.body
    text   = data.text
    token  = data.token
    key    = process.env('WUDS_TOKEN')

    if token is key
      robot.messageRoom room, "#{text}"
      res.send '200 OK'
    else
      robot.messageRoom room, ":rotating_light: *UNAUTHORIZED POSTING ATTEMPT VIA WUDS WEBHOOK* :rotating_light:"
      res.send '401 UNAUTHORIZED'
