json.extract! question, :id, :section, :active, :question, :created_at, :updated_at
json.url question_url(question, format: :json)
