# Commands:
#   hubot rick me - <gets a quote from loremricksum.com api and posts to the current channel>

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
