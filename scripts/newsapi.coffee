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
#   hubot *news me top headlines* - get top 5 headlines in the US
#   hubot *news me `query`* - get top 5 headlines for `query`
#
# Author:
#   belldavidr

module.exports = (robot) ->
  robot.respond /news me top headlines/i, (res) ->
    url = "https://newsapi.org/v2/top-headlines?country=us&pageSize=5"
    robot.http(url)
    .headers Authorization: process.env.HUBOT_NEWSAPI_KEY
    .get() (err, response, body) ->
      if err
        res.send ":rick: T-t-t-that didn't *buuurrrp* work, broh. #{err}"
        return
      else
        api = JSON.parse(body)
        if api.totalResults > "0"
          for article of api.articles
            source = api.articles[article].source.name
            title = api.articles[article].title
            description = api.articles[article].description
            link = api.articles[article].url
            res.send "*#{source}*\n #{title}\n #{link}\n"
        else
          res.send ":rick: T-t-t-that didn't *buuurrrp* work, broh. #{err}"
      return

  robot.respond /news me (.+)/i, (res) ->
    query = res.match[1]
    url = "https://newsapi.org/v2/top-headlines?q=#{query}&pageSize=5"
    robot.http(url)
    .headers Authorization: process.env.HUBOT_NEWSAPI_KEY
    .get() (err, response, body) ->
      if err
        res.send ":rick: T-t-t-that didn't *buuurrrp* work, broh. #{err}"
        return
      else
        api = JSON.parse(body)
        if api.totalResults > "0"
          for article of api.articles
            source = api.articles[article].source.name
            title = api.articles[article].title
            description = api.articles[article].description
            link = api.articles[article].url
            res.send "*#{source}*\n #{title}\n #{link}\n"
        else
          res.send ":rick: T-t-t-that didn't *buuurrrp* work, broh. #{err}"
      return

  robot.on 'news:command', (id) ->
    url = "https://newsapi.org/v2/top-headlines?country=us&pageSize=5"
    robot.http(url)
    .headers Authorization: process.env.HUBOT_NEWSAPI_KEY
    .get() (err, response, body) ->
      if err
        robot.send ":rick: T-t-t-that didn't *buuurrrp* work, broh. #{err}"
        return
      else
        api = JSON.parse(body)
        if api.totalResults > "0"
          for article of api.articles
            source = api.articles[article].source.name
            title = api.articles[article].title
            description = api.articles[article].description
            link = api.articles[article].url
            robot.send "*#{source}*\n #{title}\n #{link}\n"
        else
          robot.send ":rick: T-t-t-that didn't *buuurrrp* work, broh. #{err}"
      return
