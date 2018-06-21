module.exports = (robot) ->
  # the expected value of :room is going to vary by adapter, it might be a numeric id, name, token, or some other value
  robot.router.post '/hubot/chatsecrets/edqC7w7hMK29vfWLKEuj/:room', (req, res) ->
    room   = req.params.room
    data   = if req.body.payload? then JSON.parse req.body.payload else req.body
    text   = data.text

    robot.messageRoom room, "#{text}"
    res.send '200'
