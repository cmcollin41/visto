json.id response.id
json.report_id response.report_id
json.question_id response.question_id
json.choice_id response.choice_id
json.updated_at response.response
json.created_at response.created_at
json.updated_at response.updated_at

json.images response.images do
	json.id response.images.first.id
end