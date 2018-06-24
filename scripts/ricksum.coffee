# Description:
#   Gets quote from loremricksum.com api and posts to the current channel 
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot *rick me* - gets quote from loremricksum.com api and posts in current channel
#
# Author:
#   belldavidr

module.exports = (robot) ->
  robot.respond /rick me/i, (res) ->
    robot.http("http://loremricksum.com/api/?paragraphs=1&quotes=1")
      .header('Accept', 'application/json')
      .get() (err, response, body) ->
        if response.statusCode isnt 200
          res.send "T-t-t-that didn't *buuurrrp* work, broh."
          return

        quote = JSON.parse body
        res.send "#{quote.data}"
