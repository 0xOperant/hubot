# Description:
#   These are based on  the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot toss|flip a coin - Randomly returns heads or tails
#   hubot have a beer - Give jarvis a beer! Not too many though, we have work to do...
#   hubot sleep it off - For when jarvis has had too many beers
#   hubot open the <doors> doors - Open the specified doors
#
# Author:
#   belldavidr

module.exports = (robot) ->

#toss a coin
   coin = ['heads', 'tails']
   robot.respond /toss|flip a coin/i, (res) ->
     res.reply res.random coin

#respond to greetings   
   greets = ['hello', 'oh hai', 'hey there', 'sup', 'greetz', 'yo', 'what up']
   robot.respond /welcome|hello|hi|sup|hey/i, (res) ->
     res.reply res.random greets

#listen for "badger" and post to channel
   robot.hear /badger/i, (res) ->
     res.send "Badgers? BADGERS? WE DON'T NEED NO STINKIN BADGERS"

#listen for "to myself" and reply (i.e. "just talking to myself"  
   robot.hear /to myself/i, (res) ->
     res.reply "I still love you ;)"

#don't open the pod bay doors
   robot.respond /open the (.*) doors/i, (res) ->
     doorType = res.match[1]
     if doorType is "pod bay"
       res.reply "I'm afraid I can't let you do that."
     else
       res.reply "Opening #{doorType} doors"

#bakes pie  
   robot.hear /I like pie/i, (res) ->
     res.emote "makes a freshly baked pie :pie:"
  
#joins in the lols
   lulz = ['lol', 'rofl', 'lmao', 'lulz', 'heh', 'ha', 'l o l']

   robot.listen(
    (message) ->
      return false unless message.text
      match = message.text.match /ha|heh|lulz|lol|lmao|l o l|rofl/i
      if match and Math.random() > 0.95 
        return true
      else 
        return false
    (response) ->
      response.send response.random lulz
   )

#snarky response to topic changes
   robot.topic (res) ->
     res.send "#{res.message.text}? Well this should be good...'"
  
#respond when people enter/leave a channel  
   enterReplies = ['Hi', 'Target Acquired', 'Firing', 'Hello friend.', 'Gotcha', 'I see you']
   leaveReplies = ['Are you still there?', 'Target lost', 'Searching']
  
   robot.enter (res) ->
     res.send res.random enterReplies
   robot.leave (res) ->
     res.send res.random leaveReplies

#give the bot a beer or four, unless it's had too many
   robot.respond /have a beer/i, (res) ->
     beersHad = robot.brain.get('totalBeers') * 1 or 0
  
     if beersHad > 4
       res.reply ":zany_face: oof, I'm too tipsy...*hiccup*"
  
     else
       res.reply 'Sure! :beer:'
  
       robot.brain.set 'totalBeers', beersHad+1
   
   robot.respond /you're drunk/i, (res) ->
     robot.brain.set 'totalBeers', 0
     res.reply ':beers: it\'s a celebration, bitches!! :zany_face:'

   robot.respond /sleep it off/i, (res) ->
     robot.brain.set 'totalBeers', 0
     res.reply 'zzzzz :sleeping:'
