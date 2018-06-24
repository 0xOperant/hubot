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
#  hubot *has email `email` been pwned?* - queries haveibeenpwned.com for specified `email` address
#  hubot *has username `username` been pwned?* - queries haveibeenpwned.com paste scrapes for specified `username`
#
# Author:
#   belldavidr adapted from neufeldtech

module.exports = (robot) ->
  robot.respond /(?:has|is|was) (?:email) (\S+@\w+\.\w+) (?:been )?pwned\??/i, (res) ->
    email = res.match[1]
    url = "https://haveibeenpwned.com/api/v2/breachedaccount/#{email}?truncateResponse=true&includeUnverified=true"
    robot.http(url).get() (err, response, body) ->
      if err
        res.send ":disappointed: Encountered an error: #{err}"
        return
      else if response.statusCode is 404
        res.send ":tada: You're in the clear; #{email} not found! :tada:"
        return
      else
        if response.statusCode == 200
          body = JSON.parse(body)
          pwnedSites = ""
          i = 0
          while i < body.length
            pwnedSites += "#{body[i].Name}\n"
            i++
          res.send ":sob: Yes, #{email} was in the following breaches:\n```#{pwnedSites}```"
          return

  robot.respond /has username (.*) been pwned/i, (res) ->
    account = res.match[1]
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
            pwnedSites += "#{body[i].Name}\n"
            i++
          res.send ":sob: Yes, #{account} has been found on the following pastes:\n```#{pwnedSites}```"
          return
