#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

module.exports = (robot) ->
   
   greets = ['hello', 'hi', 'oh hai', 'hey there', 'sup', 'greetz', 'yo', 'what up']
   robot.respond /hello|hi|sup|hey/i, (res) ->
     res.reply res.random greets

#listen for "badger" and post to channel
   robot.hear /badger/i, (res) ->
     res.send "Badgers? BADGERS? WE DON'T NEED NO STINKIN BADGERS"

#listen for "to myself" and reply  
   robot.hear /to myself/i, (res) ->
     res.reply "I still love you ;)"

   robot.respond /open the (.*) doors/i, (res) ->
     doorType = res.match[1]
     if doorType is "pod bay"
       res.reply "I'm afraid I can't let you do that."
     else
       res.reply "Opening #{doorType} doors"
  
   robot.hear /I like pie/i, (res) ->
     res.emote "makes a freshly baked pie"
  
   lulz = ['lol', 'rofl', 'lmao', 'lulz', 'l o l']
  
   robot.hear /lulz|lol|lmao|l o l|rofl/i, (res) ->
     res.send res.random lulz
  
   robot.topic (res) ->
     res.send "#{res.message.text}? That's a Paddlin'"
  
  
   enterReplies = ['Hi', 'Target Acquired', 'Firing', 'Hello friend.', 'Gotcha', 'I see you']
   leaveReplies = ['Are you still there?', 'Target lost', 'Searching']
  
   robot.enter (res) ->
     res.send res.random enterReplies
   robot.leave (res) ->
     res.send res.random leaveReplies

   robot.respond /have a beer/i, (res) ->
     beersHad = robot.brain.get('totalBeers') * 1 or 0
  
     if beersHad > 4
       res.reply "oof, I'm too tipsy...*hiccup*"
  
     else
       res.reply 'Sure!'
  
       robot.brain.set 'totalBeers', beersHad+1
  
   robot.respond /sleep it off/i, (res) ->
     robot.brain.set 'totalBeers', 0
     res.reply 'zzzzz'
