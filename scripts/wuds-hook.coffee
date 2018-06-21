module.exports = (robot) ->
  # the expected value of :room is going to vary by adapter, it might be a numeric id, name, token, or some other value
  robot.router.post '/hubot/chatsecrets/:room', (req, res) ->
    room   = req.params.room
    data   = if req.body.payload? then JSON.parse req.body.payload else req.body
    text   = data.text
    token  = data.token
    key    = "edqC7w7hMK29vfWLKEuj"

    if token is key
      robot.messageRoom room, "#{text}"
      res.send '200 OK'
    else
      res.send '401 UNAUTHORIZED'
