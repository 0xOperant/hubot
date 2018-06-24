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
#   belldavidr (adapted from neufeldtech)

module.exports = (robot) ->
  robot.hear /(?:has|is) (\S+@\w+\.\w+) (?:been )?pwned\??/i, (msg) ->
    email = msg.match[1]
    robot.http("https://haveibeenpwned.com/api/v2/breachedaccount/"+email)
      .header('Accept', 'application/json')
      .get() (err, res, body) ->
        if err
          res.send "Encountered an error :( #{err}"
          return

        body = JSON.parse(body)
        res.send "#{body.name}"
