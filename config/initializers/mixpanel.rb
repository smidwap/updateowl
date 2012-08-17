require 'analytics'

config_path = File.expand_path(File.dirname(__FILE__) + "/../mixpanel.yml")
cfg = YAML.load(File.read(config_path))

$mixpanel_event_builder = MixpanelEventBuilder.new(cfg[Rails.env]['token'])