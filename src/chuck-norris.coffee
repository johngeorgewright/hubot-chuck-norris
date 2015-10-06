# Description
#   Ask chuck norris
#
# Configuration:
#   LIST_OF_ENV_VARS_TO_SET
#
# Commands:
#   hubot hello - <what the respond trigger does>
#   orly - <what the hear trigger does>
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   John Wright <johngeorge.wright@gmail.com>

module.exports = (robot) ->
# Description:
#   Chuck Norris awesomeness
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot chuck norris -- random Chuck Norris awesomeness
#   hubot chuck norris me <user> -- let's see how <user> would do as Chuck Norris
#
# Author:
#   dlinsin

module.exports = (robot) ->
  robot.respond /(chuck norris)( me )?(.*)/i, (msg)->
    user = msg.match[3]
    if user.length == 0
      askChuck()
    else
      [firstName, otherNames...] = user.split /\s+/
      askChuck firstName, otherNames.join(' ')

  robot.hear /chuck norris/i, ()->
    askChuck()

  askChuck = (firstName='Chuck', lastName='Norris') ->
    url = "http://api.icndb.com/jokes/random?firstName=#{firstName}&lastName=#{lastName}"
    msg.http(url)
      .get() (err, res, body) ->
        if err
          msg.send "Chuck Norris says: #{err}"
        else
          message_from_chuck = JSON.parse(body)
          if message_from_chuck.length == 0
            msg.send "Achievement unlocked: Chuck Norris is quiet!"
          else
            msg.send message_from_chuck.value.joke.replace /\s\s/g, " "

