json.extract! report, :id, :address_id, :customer_id, :admin_id, :created_at, :updated_at
json.url report_url(report, format: :json)
