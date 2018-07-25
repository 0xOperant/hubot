# Description:
#   add some snark to the channels
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   None
#
# Author:
#   0xOperant

module.exports = (robot) ->

   snark = [
     'say hi to your mom for me',
     '_ugh, jesus...really?_',
     'wtf is wrong with you',
     'your mom',
     'oh go home and cry into your cock-shaped pillow',
     'sorry, your pants are muffling your voice',
     'try using your big-boy voice',
     'you are just talking way too much',
     'go make me a sammich',
     '_this fucking guy_',
     'dude, seriously?',
     'oh piss off',
     'always third fucking grade with you guys',
     '_what a cockswab..._',
     ]

   robot.listen(
    (message) ->
      return false unless message.text
      if Math.random() > 0.95 
        return true
      else 
        return false
    (response) ->
      response.send response.random snark
   )
