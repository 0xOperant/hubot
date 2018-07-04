# Description
#   Get top US headlines from newsapi.org
#
# Dependencies:
#   newsapi
#
# Configuration:
#   NEWSAPI_KEY
#
# Commands:
#   hubot *news me top headlines* - get top headlines
#
# Author:
#   belldavidr

url = "https://newsapi.org/v2/""

module.exports = (robot) ->
  robot.respond /news me (.*)/i, (res) ->
    if res.match[1] = "top headlines"
      url = url
      robot.http(url + "top-headlines?country=us")
      .headers Authorization: process.env.NEWSAPI_KEY
      .get() (err, response, body) ->
        if err
          res.send ":rick: T-t-t-that didn't *buuurrrp* work, broh. #{err}"
          return
        else
          api = JSON.parse(body)
          if api.status is ok
            for article in body.articles
              source = body.articles[article].source
              title = body.articles[article].title
              description = body.articles[article].description
              link = body.articles[article].url
              res.reply "Here are the current top headlines in the US:\n From #{source}: #{title}\n #{description}\n #{link}"
          else
            res.send ":rick: T-t-t-that didn't *buuurrrp* work, broh. #{err}"
        return
