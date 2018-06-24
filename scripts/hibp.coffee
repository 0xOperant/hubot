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
#  hubot *has email `email address` been pwned?* - queries haveibeenpwned.com for specified `email address`
#  hubot *has username `email address` been pwned?* - queries haveibeenpwned.com paste scrapes for specified `email address`
#
# Author:
#   belldavidr adapted from neufeldtech

module.exports = (robot) ->
  robot.respond /(?:has|is|was) (email|username) (\S+@\w+\.\w+) (?:been )?pwned\??/i, (res) ->
    account = res.match[1]
    if email in res.match[0]
      url = "https://haveibeenpwned.com/api/v2/breachedaccount/#{account}?truncateResponse=true&includeUnverified=true"
    else
      url = "https://haveibeenpwned.com/api/v2/pasteaccount/#{account}"
    robot.http(url).get() (err, response, body) ->
      if err
        res.send ":disappointed: Encountered an error: #{err}"
        return
      else if response.statusCode is 404
        res.send ":tada: You're in the clear; #{account} not found! :tada:"
        return
      else
        if response.statusCode == 200
          body = JSON.parse(body)
          pwnedSites = ""
          i = 0
          while i < body.length
            if Name in body
              pwnedSites += "#{body[i].Name}\n"
            else 
              pwnedSites += "#{body[i].Source}\n"
            i++
          res.send ":sob: Yes, #{email} was in the following:\n```#{pwnedSites}```"
          return
