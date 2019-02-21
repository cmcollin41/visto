class Response < ApplicationRecord
  belongs_to :report
  belongs_to :question, optional: true

  has_many_attached :images
end
