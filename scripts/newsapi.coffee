# Description
#   Get top US headlines from newsapi.org
#
# Dependencies:
#   newsapi
#
# Configuration:
#   HUBOT_NEWSAPI_KEY
#
# Commands:
#   hubot *news me top headlines* - get top headlines
#
# Author:
#   belldavidr

url = "https://newsapi.org/v2/top-headlines?country=us&pageSize=5"

module.exports = (robot) ->
  robot.respond /news me top headlines/i, (res) ->
    res.reply "Getting headlines..."
    url = url
    robot.http(url)
    .headers Authorization: process.env.HUBOT_NEWSAPI_KEY
    .get() (err, response, body) ->
      if err
        res.send ":rick: T-t-t-that didn't *buuurrrp* work, broh. #{err}"
        return
      else
        api = JSON.parse(body)
        if api.totalResults > "0"
          res.reply "Here are the current top five headlines in the US:\n"
          for article of api.articles
            source = api.articles[article].source
            title = api.articles[article].title
            description = api.articles[article].description
            link = api.articles[article].url
            res.send "#{link}"
        else
          res.send ":rick: T-t-t-that didn't *buuurrrp* work, broh. #{err}"
      return
