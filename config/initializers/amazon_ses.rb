config_path = File.expand_path(File.dirname(__FILE__) + "/../aws.yml")
cfg = YAML.load(File.read(config_path))

ActionMailer::Base.add_delivery_method :ses, AWS::SES::Base,
  :access_key_id     => cfg[Rails.env]['access_key_id'],
  :secret_access_key => cfg[Rails.env]['secret_access_key']