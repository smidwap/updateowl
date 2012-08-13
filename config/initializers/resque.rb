require 'resque_scheduler'
require 'resque_scheduler/server'

Resque.redis = $redis
Resque.redis.namespace = "resque:UpdateOwl"
Resque.schedule = YAML.load_file('config/resque_schedule.yml')

# Don't queue jobs in Redis if we're in test environment
# This avoids the jobs actually being performed and mucking with the dev db
Resque.inline = true if Rails.env == "test"