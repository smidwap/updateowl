
redis_config_path = File.expand_path(File.dirname(__FILE__) + "/../redis.yml")
redis_cfg = YAML.load(File.read(redis_config_path))[Rails.env]

$redis = Redis.new(host: redis_cfg['host'], port: redis_cfg['port'], password: redis_cfg['password'])

# Avoid the "mysql server has gone away" error when processing jobs.
Resque.after_fork = Proc.new { |job|
  ActiveRecord::Base.retrieve_connection
  ActiveRecord::Base.verify_active_connections! 
}