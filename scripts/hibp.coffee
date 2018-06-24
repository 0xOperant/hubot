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
#  hibp <email>
#
# Author:
#   belldavidr (adapted from neufeldtech)

module.exports = (robot) ->
  robot.hear /hibp (\S+@\w+\.\w+)/i, (msg) ->
    email = msg.match[1]
    robot.http("https://haveibeenpwned.com/api/v2/breachedaccount/"+email+"/?truncateResponse=true&includeUnverified=true")
    .get() (err, res, body) ->
      if err
        res.send "Encountered an error :( #{err}"
        return
      else
        if res.statusCode == 200
          body = JSON.parse(body)
          pwnedSites = ""
          i = 0
          while i < body.length
            pwnedSites += "#{body[i].Domain}\n"
            i++
          msg.send "Yes, #{email} has been pwned :sob:\n```#{pwnedSites}```"
          return
        else if res.statusCode == 404
          msg.send "Nope, #{email} has not been pwned :tada:"
          return
        else
          msg.send "Encountered an error :("
          return
