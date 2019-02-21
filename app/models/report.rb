class Report < ApplicationRecord
  belongs_to :address, optional: true
  belongs_to :customer, optional: true
  belongs_to :admin, optional: true

  has_many :responses, dependent: :destroy
  accepts_nested_attributes_for :responses, allow_destroy: true
end