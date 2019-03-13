Rubillow.configure do |configuration|
  configuration.zwsid = Rails.application.credentials.zillow[:zillow_id]
end