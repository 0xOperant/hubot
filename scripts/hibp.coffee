# Description:
#  Queries the haveibeenpwned.com api (v2) for the specified email address
#
# Dependencies
#  None
#
# Configuration:
#  None
#
# Commands:
#  hubot *hibp check `email address`* - queries haveibeenpwned.com for specified `email address`
#
# Author:
#   belldavidr adapted from neufeldtech

module.exports = (robot) ->
  robot.respond /hibp (?:check) (\S+@\w+\.\w+)/i, (res) ->
    account = res.match[1]
    breach = "https://haveibeenpwned.com/api/v2/breachedaccount/#{account}?includeUnverified=true"
    pastes = "https://haveibeenpwned.com/api/v2/pasteaccount/#{account}"
    robot.http(breach).get() (err, response, body) ->
      if err
        res.send ":disappointed: Encountered an error while searching breaches: #{err}"
        return
      else
        if response.statusCode is 404
          res.send ":tada: #{account} not found in any breaches! :tada:"
          return
        else
          if response.statusCode == 200
            body = JSON.parse(body)
            pwnedSites = ""
            i = 0
            while i < body.length
              pwnedSites += "#{body[i].Name}\n"
              i++
            res.send ":sob: Yes, #{account} was found in the following breach(es):\n```#{pwnedSites}```"
            return
    robot.http(pastes).get() (err, response, body) ->
      if err
        res.send ":disappointed: Encountered an error while searching pastes: #{err}"
        return
      else
        if response.statusCode is 404
          res.send ":tada: #{account} not found in any pastes! :tada:"
          return
        else
          if response.statusCode == 200
            body = JSON.parse(body)
            pwnedSites = ""
            i = 0
            while i < body.length
              pwnedSites += "#{body[i].Name}\n"
              i++
            res.send ":sob: Yes, #{account} was in the following paste(s):\n```#{pwnedSites}```"
            return
