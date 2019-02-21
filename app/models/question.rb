class Question < ApplicationRecord
	has_many :choices, inverse_of: :question
	has_many :responses, inverse_of: :question

	accepts_nested_attributes_for :choices, reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :responses, allow_destroy: true
	
end
