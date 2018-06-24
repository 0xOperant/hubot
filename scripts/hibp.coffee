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
#  hubot *hibp check email* <email> - queries haveibeenpwned.com for specified 'email' address
#  hubot *hibp check pastes* <username> - queries haveibeenpwned.com for specified 'username'
#
# Author:
#   belldavidr (adapted from neufeldtech)

module.exports = (robot) ->
  robot.hear /hibp check email (\S+@\w+\.\w+)/i, (res) ->
    email = res.match[1]
    robot.http("https://haveibeenpwned.com/api/v2/breachedaccount/"+email+"/?truncateResponse=true&includeUnverified=true")
    .get() (err, res, body) ->
      if err
        res.send "Encountered an error :( #{err}"
        return
      else
        if res.statusCode == 200
          body = JSON.parse(body)
          res.send "#{body}"
          pwnedSites = ""
          i = 0
          while i < body.length
            pwnedSites += "#{body[i].Domain}\n"
            i++
          res.send "Yes, #{email} has been pwned :sob:\n```#{pwnedSites}```"
          return
        else if res.statusCode == 404
          res.send "Nope, #{email} has not been pwned :tada:"
          return
        else
          res.send "Encountered an error :("
          return

#  robot.hear /hibp check pastes (.*)/i, (res) ->
#    paste = res.match[1]
#    robot.http("https://haveibeenpwned.com/api/v2/pasteaccount/"+paste)
#    .get() (err, res, body) ->
#      if err
#        res.send "Encountered an error :( #{err}"
#        return
#      else
#        if res.statusCode == 200
#          body = JSON.parse(body)
#          pwnedSites = ""
#          i = 0
#          while i < body.length
#            pwnedSites += "#{body[i].Domain}\n"
#            i++
#          res.send "Yes, #{email} has been pwned :sob:\n```#{pwnedSites}```"
#          return
#        else if res.statusCode == 404
#          res.send "Nope, #{email} has not been pwned :tada:"
#          return
#        else
#          res.send "Encountered an error :("
#          return

