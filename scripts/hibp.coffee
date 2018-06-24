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
#   belldavidr

module.exports = (robot) ->
  robot.respond /(?:has|is) (\S+@\w+\.\w+) (?:been )?pwned\??/i, (res) ->
    email = res.match[1]
    res.send "checking haveibeenpwned.com for  #{email}..."
    robot.http("https://haveibeenpwned.com/api/v2/breachedaccount/"+email)
      .get() (err, response, body) ->
        if response.statusCode is 404
          res.send "You're in the clear; #{email} not found."
          return

        body = JSON.parse body
        res.send "#{email} was found in the following breach(es): #{body.name}"
