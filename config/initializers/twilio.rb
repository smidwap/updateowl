config_path = File.expand_path(File.dirname(__FILE__) + "/../twilio.yml")
cfg = YAML.load(File.read(config_path))

$twilio = Twilio::REST::Client.new cfg[Rails.env]['sid'], cfg[Rails.env]['auth_token']