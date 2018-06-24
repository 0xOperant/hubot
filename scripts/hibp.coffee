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
  robot.respond /hibp (?:check|has|is|was) (\S+@\w+\.\w+) (?:been )?pwned\??/i, (res) ->
    account = res.match[1]
    url = "https://haveibeenpwned.com/api/v2/breachedaccount/#{account}?truncateResponse=false&includeUnverified=true"
    robot.http(url).get() (err, response, body) ->
      if err
        res.send ":disappointed: Encountered an error: #{err}"
        return
      else
        if response.statusCode is 404
          res.send ":tada: You're in the clear; #{account} not found! :tada:"
          return
        else
          if response.statusCode == 200
            body = JSON.parse(body)
            pwnedSites = ""
            i = 0
            while i < body.length
              pwnedSites += "#{body[i].Name}\n"
              i++
            res.send ":sob: Yes, #{account} was in the following:\n```#{pwnedSites}```"
            return
