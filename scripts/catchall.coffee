# Description:
#  catchall to point users to the help cruft
#
# Dependencies:
#  None
#
# Commands:
#  None
#
# Author
#  0xOperant

module.exports = (robot) ->
  
  snark = [
     'now *that* is just _dumb_',
     'you first, pussy',
     '_ugh, jesus fuck, really...?_',
     'wtf is wrong with you',
     'sorry, your pants are muffling your voice',
     'try using your big-boy voice',
     '_this fucking guy..._',
     'dude, seriously?',
     'oh piss off',
     ':face_with_rolling_eyes:',
     'why are you stupid?',
     ':troll:',
     'I do not know that command. For help: _lol nobody gives a fuck_',
     'hold my beer',
     'No, bitch',
     '_what a cocksplat_',
     'well, who put a quarter in you',
     ':middle_finger:',
     ':middle_finger::middle_finger:',
     'do it your *damn* self',
     'lolno :middle_finger:'
     ]
  
  robot.catchAll (res) ->
    match = /^\@ultron+/i.test(res.message.text)
    if match 
      res.reply res.random snark
