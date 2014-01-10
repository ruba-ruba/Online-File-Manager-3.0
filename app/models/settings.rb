class Settings < Settingslogic
  source "#{Rails.root}/config/settings.yml"
  namespace Rails.env
  suppress_errors Rails.env.production?
end