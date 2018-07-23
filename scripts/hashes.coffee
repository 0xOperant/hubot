# Description:
#  Queries the hashes.org api (v2) for plaintext, given a hash
#
# Dependencies
#  None
#
# Configuration:
#  HASHES_API_KEY from hashes.org (user account required)
#
# Commands:
#  hubot *hash check `hash`* - queries hashes.org to see if `hash` has already been cracked
#
# Author:
#   belldavidr

token = process.env.HASHES_API_KEY

module.exports = (robot) ->
  robot.respond /hash (?:check) (.*)/i, (res) ->
    hash = res.match[1]
    url = "https://hashes.org/api.php?key=#{token}&query=#{hash}"
    robot.http(url).get() (err, response, body) ->
      if err
        res.send ":rick: T-t-t-that didn't *buuurrrp* work, broh. #{err}"
        return
      else
        api = JSON.parse(body)
        res.send api
        if "null" not in api.result
          for entry of api.result
            plain = api.result[entry].plain
            algo = api.result[entry].algorithm
            res.send "#{algo} hash: #{entry} = #{plain}"
        else
          res.send "Hash #{hash} is not in the hashes.org database."
