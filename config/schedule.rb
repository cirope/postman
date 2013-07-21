# Learn more: http://github.com/javan/whenever
#
# Update development cron tab
# whenever --set environment=development --update-crontab postman
# Remove it with
# whenever -c postman

every 2.minutes do
  rake 'email:fetch'
end
