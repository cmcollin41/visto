json.extract! address, :id, :name, :long_address, :latitude, :longitude, :created_at, :updated_at
json.url address_url(address, format: :json)
