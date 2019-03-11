json.extract! item, :id, :response_id, :number, :size, :fuel_type, :notes, :created_at, :updated_at
json.url item_url(item, format: :json)
