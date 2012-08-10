Resque.redis = $redis
Resque.redis.namespace = "resque:UpdateOwl"

# Don't queue jobs in Redis if we're in test environment
# This avoids the jobs actually being performed and mucking with the dev db
Resque.inline = true if Rails.env == "test"