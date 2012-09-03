require 'to_lang'

config_path = File.expand_path(File.dirname(__FILE__) + "/../google.yml")
cfg = YAML.load(File.read(config_path))

ToLang.start(cfg[Rails.env]['api_key'])