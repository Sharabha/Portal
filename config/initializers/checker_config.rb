#load configuration for communication between portal and checker

CHECKER_CONFIG = YAML.load_file("#{Rails.root.to_s}/config/checker.yml")[Rails.env]
