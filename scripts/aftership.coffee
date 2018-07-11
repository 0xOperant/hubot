# Description
#   Track your packages
#
# Configuration:
#   AFTERSHIP_API_KEY
#   AFTERSHIP_SECRET
#
# Commands:
#   hubot *track me `trackingnumber` `name`* - provide tracking number and a name
#   hubot *track info `name`* - get current info for the specified `name`
#
# Author:
#   François de Metz
#   brain, user functions added by belldavidr

Aftership = require('aftership')(process.env.AFTERSHIP_API_KEY)
url = require('url')
querystring = require('querystring')
moment = require('moment')

translateStatus = (status) ->
  statuses =
    Pending: 'pending'
    InfoReceived: 'info received'
    InTransit: 'in transit'
    OutForDelivery: ':truck:'
    AttemptFail: 'attempt fail'
    Delivered: ':white_check_mark:'
    Exception: ':heavy_exclamation_mark:'
    Expired: 'expired'

  statuses[status]

printTrackingCurrentInfo = (tracking) ->
  if tracking.custom_fields.item? then item = tracking.custom_fields.item
  else
    item = trackings.custom_fields.item
  res.send "item = #{item}"
  if tracking.tag? then tag = tracking.tag
  else
    tag = trackings.tag
  res.send "tag = #{tag}"
  ":package: Current status of package #{item} is: *#{translateStatus(tag)}*."

printCheckPointsInfo = (checkpoints) ->
  msgs = checkpoints.reverse().map (checkpoint) ->
    "- #{moment(checkpoint.checkpoint_time).fromNow()}: #{translateStatus(checkpoint.tag)} #{checkpoint.message}."
  msgs.join("\n")

module.exports = (robot) ->
  robot.respond /track me (.+) (.+)/i, (res) ->
    name = res.match[2]
    params =
      body:
        tracking:
          tracking_number: res.match[1]
          custom_fields:
            room: res.message.room
            item: "#{name}"
            user: res.message.user.id
    Aftership.call 'POST', '/trackings', params, (err, result) ->
      if err
        res.reply "error: #{err.message}"
        return
      else
        tracking = result.data.tracking
        robot.brain.set('#{name}', tracking.id)
        res.reply ":package: Package tracked. Use `track info #{name}` for on-demand updates."

  robot.respond /track info (.+)/i, (res) ->
    name = res.match[1]
    id = robot.brain.get('#{name}')
    if id?
      Aftership.call 'GET', "/trackings/#{id}", (err, result) ->
        return res.reply "error: #{err.message}" if err
        tracking = result.data.tracking
        if tracking.custom_fields.user is res.message.user.id
          res.reply printTrackingCurrentInfo(tracking) + "\n" + printCheckPointsInfo(tracking.checkpoints)
          return
        else
          res.reply "I'm not tracking any active packages for you by that name: (#{name})"
    else
      res.reply "I'm not tracking any active packages by that name: (#{name})"
      return

  robot.respond /track list/i, (res) ->
    Aftership.call 'GET', "/trackings?keyword=#{res.message.user.id}&fields=checkpoints,checkpoint_time,tag,message", (err, result) ->
      return res.reply "error: #{err.message}" if err
      res.send "meta code = #{result.meta.code}"
      if result.data.count > "0"
        res.send "count = #{result.data.count}"
        for tracking of result.data.trackings
          res.reply printTrackingCurrentInfo(tracking) + "\n" + printCheckPointsInfo(tracking.checkpoints)
          return
      else
        res.reply "I'm not tracking any active packages for you right now."

  robot.router.post '/aftership', (req, res) ->
    query = querystring.parse(url.parse(req.url).query)
    data   = if req.body.payload? then JSON.parse req.body.payload else req.body
    secret = query.secret
    return res.status(403).send("NOK") if secret != process.env.AFTERSHIP_SECRET
    return res.status(200).send("OK") if data.msg.id == "000000000000000000000000"
    room   = data.msg.custom_fields?.room
    return res.status(400).send("NOK") if not room

    tracking = data.msg
    robot.messageRoom room, printTrackingCurrentInfo(tracking) + "\n" + printCheckPointsInfo([tracking.checkpoints.reverse()[0]])

    res.send 'OK'
