# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
set :output, '~/cron_log.log'
set :chronic_options, hours24: true
every '0 0 * * *' do
  rake 'backup:dump', output: '/dev/null'
end
every '1 0 * * *' do
  rake 'backup:gitadd'
end
every '2 0 * * *' do
  rake 'backup:gitcommit'
end
every '3 0 * * *' do
  rake 'backup:gitpush'
end
every '4 0 * * *' do
  rake 'serverchat:start'
end
every '5 0 * * *' do
  command 'cd /home/cmc-global/tricom; bundle exec rails runner scripts/remove_old_data.rb'
  command 'cd /home/cmc-global/tricom; bundle exec rails runner scripts/log_clear.rb'
end
