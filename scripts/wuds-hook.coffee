module.exports = (robot) ->
  # the expected value of :room is going to vary by adapter, it might be a numeric id, name, token, or some other value
  robot.router.post '/hubot/chatsecrets/:room', (req, res) ->
    room   = req.params.room
    data   = if req.body.payload? then JSON.parse req.body.payload else req.body
    secret = data.secret
    token = data.token
    key = "totallyrandomstring"

    if token is key
      robot.messageRoom room, "#{secret}, #{token}, #{key}"
      res.send '200'
    else res.send '404'
