# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, "log/crons.log"
env :PATH,'/home/donbillete/.rbenv/shims:/home/donbillete/.rbenv/bin:/home/donbillete/.rbenv/bin:/usr/local/jdk/bin:/home/donbillete/perl5/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11R6/bin:/home/donbillete/bin'
every 1.minutes do
  runner "Game.close_lottery_buy"
end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
