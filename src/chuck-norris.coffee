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

module.exports = (robot)->
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

module.exports = (robot)->
  robot.respond /^(chuck norris)( me )?\s*(.*)/i, (res)->
    http = res.http.bind res
    send = res.reply.bind res
    user = res.match[3]
    if user.length == 0
      askChuck http, send
    else
      [firstName, otherNames...] = user.split /\s+/
      askChuck http, send, firstName, otherNames.join(' ')

  robot.hear /chuck norris/i, (res)->
    askChuck res.http.bind(res), res.send.bind(res)

  askChuck = (req, res, firstName='Chuck', lastName='Norris')->
    url = "http://api.icndb.com/jokes/random?firstName=#{firstName}&lastName=#{lastName}"
    req(url)
      .get() (err, _, body)->
        if err
          res "Chuck Norris says: #{err}"
        else
          messageFromChuck = JSON.parse body
          if messageFromChuck.type is 'success'
            res messageFromChuck.value.joke.replace /\s\s/g, ' '
          else
            res 'Achievement unlocked: Chuck Norris is quiet!'
