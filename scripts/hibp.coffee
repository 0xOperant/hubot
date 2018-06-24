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
#  hubot *has  `email` been pwned?* - queries haveibeenpwned.com for specified 'email' address
#  hubot *has `username` been pwned?* - queries haveibeenpwned.com for specified 'username'
#
# Author:
#   belldavidr adapted from neufeldtech

module.exports = (robot) ->
  robot.respond /(?:has|is) (\S+@\w+\.\w+) (?:been )?pwned\??/i, (res) ->
    email = res.match[1]
    url = "https://haveibeenpwned.com/api/v2/breachedaccount/#{email}"
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
            pwnedSites += "#{body[i].Domain}\n"
            i++
          res.send "Yes, #{email} has been pwned :sob:\n```#{pwnedSites}```"
          return
