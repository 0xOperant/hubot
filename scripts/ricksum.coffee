# Commands:
#   hubot rick me <# quotes (optional)> - Gets quote(s) from loremricksum.com api and posts to the current channel

module.exports = (robot) ->
  robot.respond /rick me (.*)/i, (res) ->
    q = escapte(res.match[1])
    robot.http("http://loremricksum.com/api/?paragraphs=1&quotes=#{q}")
      .header('Accept', 'application/json')
      .get() (err, response, body) ->
        if response.statusCode isnt 200
          res.send "Request didn't come back HTTP 200 :("
          return

        quote = JSON.parse body
        res.send "#{quote.data}"

#  robot.respond /ricksum (.*), (.*)/i, (res) ->
#    p = escape(res.match[1])
#    q = escape(res.match[2])
#    robot.http("http://loremricksum.com/api/?paragraphs=#{p}&quotes=#{q}")
#    .get() (err, response, body) ->
#        if response.statusCode isnt 200
#          res.send "Request didn't come back HTTP 200 :("
#          return
#
#        quote = JSON.parse body
#        res.send "#{quote.data}"
