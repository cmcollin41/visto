json.extract! job, :id, :price, :time, :date, :address_id, :customer_id, :created_at, :updated_at
json.url job_url(job, format: :json)
