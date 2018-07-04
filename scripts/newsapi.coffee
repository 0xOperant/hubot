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

url = "https://newsapi.org/v2/top-headlines?country=us"

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
        res.send "api = #{api}\n body = #{body}"
        if ok in api.status
          for article in api.articles
            source = api.articles[article].source
            title = api.articles[article].title
            description = api.articles[article].description
            link = api.articles[article].url
            res.reply "Here are the current top headlines in the US:\n From #{source}: #{title}\n #{description}\n #{link}"
        else
          res.send ":rick: T-t-t-that didn't *buuurrrp* work, broh. #{err}"
      return
