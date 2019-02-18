class Response < ApplicationRecord
  belongs_to :report
  has_many_attached :images
end
