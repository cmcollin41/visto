class Question < ApplicationRecord
	has_many :choices, inverse_of: :question
	has_many :responses, inverse_of: :question

	enum section: { roof: 1, exterior: 2, bfcs: 3, heating: 4, cooling: 5, plumbing: 6, electrical: 7, fireplace: 8,
	attic: 9, interior: 10, optional: 11 }

	accepts_nested_attributes_for :choices, reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :responses, allow_destroy: true
	
end
