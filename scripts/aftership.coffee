# Description
#   Track your packages
#
# Configuration:
#   AFTERSHIP_API_KEY
#   AFTERSHIP_SECRET
#
# Commands:
#   hubot *track me `trackingnumber` `name`* - provide tracking number and a name
#   hubot *track info `name`* - get current info for the tracking id or name
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

printTrackingCurrentInfo = (tracking, name) ->
  ":package: Package #{name}: Current status is #{translateStatus(tracking.tag)}."

printCheckPointsInfo = (checkpoints) ->
  msgs = checkpoints.reverse().map (checkpoint) ->
    "- #{moment(checkpoint.checkpoint_time).fromNow()} #{translateStatus(checkpoint.tag)} #{checkpoint.message}."
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
    Aftership.call 'POST', '/trackings', params, (err, result) ->
      return res.reply("err #{err.message}") if err
      id = result.data.tracking.id
      robot.brain.set('#{name}', '#{id}')
      res.reply ":package: Package tracked. Use track info #{name}."

  robot.respond /track info (.+)/i, (res) ->
    name = res.match[1]
    id = robot.brain.get('#{name}')
    res.send "name = #{id}"
    Aftership.call 'GET', "/trackings/#{id}", (err, result) ->
      return res.reply "err #{err.message}" if err
      tracking = result.data.tracking
      res.reply printTrackingCurrentInfo(tracking, name) + "\n" + printCheckPointsInfo(tracking.checkpoints)

  robot.router.post '/aftership', (req, res) ->
    query = querystring.parse(url.parse(req.url).query)
    data   = if req.body.payload? then JSON.parse req.body.payload else req.body
    secret = query.secret
    return res.status(403).send("NOK") if secret != process.env.AFTERSHIP_SECRET
    return res.status(200).send("OK") if data.msg.id == "000000000000000000000000"
    room   = data.msg.custom_fields?.room
    item   = data.msg.custom_fields?.item
    return res.status(400).send("NOK") if not room

    tracking = data.msg
    robot.messageRoom room, "Tracking update for #{item}:" + printTrackingCurrentInfo(tracking) + "\n" + printCheckPointsInfo([tracking.checkpoints.reverse()[0]])

    res.send 'OK'
