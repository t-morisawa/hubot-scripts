child_process = require 'child_process'

module.exports = (robot) ->
  robot.hear /update/i, (bot) ->
    try
      bot.send "updating..."
      child_process.exec 'GIT_DIR=hubot-scripts/.git git pull origin master', (error, stdout, stderr) ->
        if error
          robot.logger.debug
          bot.send "git pull failed: " + stderr
        else
          output = stdout+''

          if not /Already up\-to\-date/.test output
            robot.logger.debug "bot updated" + output
            bot.send "bot updated" + output
            process.exit()
          else
            bot.send "up-to-date"
            robot.logger.debug "up-to-date"
    catch e
      robot.logger.debug "git pull failed:" + e
      bot.send "git pull failed: " + stderr
