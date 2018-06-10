# Commands:
#   hubot rick me - Gets a single quote from loremricksum.com api and posts to the current channel
#   hubot ricksum <# paragraphs> <# quotes per paragraph> - Mashes specified number of paragraphs and sentences from loremriscksum.com api and posts to current channel

module.exports = (robot) ->
  robot.respond /rick me/i, (res) ->
    robot.http("http://loremricksum.com/api/?paragraphs=1&quotes=1")
      .header('Accept', 'application/json')
      .get() (err, response, body) ->
        if response.statusCode isnt 200
          res.send "Request didn't come back HTTP 200 :("
          return

        quote = JSON.parse body
        res.send "#{quote.data}"

  robot.respond /ricksum (.*)/i, (msg) ->
    p = escape(msg.match[1])
    q = escape(msg.match[2])
    robot.http("http://loremricksum.com/api/?paragraphs={p}&quotes={q}")
    .get() (err, response, body) ->
        if response.statusCode isnt 200
          res.send "Request didn't come back HTTP 200 :("
          return

        quote = JSON.parse body
        res.send "#{quote.data}"
