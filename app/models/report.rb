class Report < ApplicationRecord
  belongs_to :address
  belongs_to :customer
  belongs_to :admin

  has_many :responses
  accepts_nested_attributes_for :responses, reject_if: :all_blank, allow_destroy: true
end