class Settings < Settingslogic
  source File.expand_path('../../../config/application.yml', __FILE__)
  namespace Rails.env
end
