json.extract! response, :id, :report_id, :question_id, :choice_id, :created_at, :updated_at
json.url response_url(response, format: :json)
