config_path = File.expand_path(File.dirname(__FILE__) + "/../google_analytics.yml")

$google_analytics_config = YAML.load(File.read(config_path))