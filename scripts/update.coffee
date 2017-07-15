child_process = require 'child_process'

module.exports = (robot) ->
  robot.hear /bot.*update/, (bot) ->
    try
      robot.adapter.notice bot.envelope, "updating..."
      child_process.exec 'git pull origin master', (error, stdout, stderr) ->
        if error
          robot.adapter.notice bot.envelope, "git pull failed: " + stderr
        else
          output = stdout+''
          if not /Already up\-to\-date/.test output
            robot.adapter.notice bot.envelope, "bot updated" + output
            robot.adapter.notice bot.envelope, "to be rebooted."
            process.exit()
          else
            robot.adapter.notice bot.envelope, "up-to-date"
    catch e
      robot.adapter.notice bot.envelope, "git pull failed:" + e
