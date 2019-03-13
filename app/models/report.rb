class Report < ApplicationRecord
  belongs_to :address, optional: true
  belongs_to :customer, optional: true
  belongs_to :admin, optional: true

  # has_many :responses, dependent: :destroy
  # accepts_nested_attributes_for :responses, allow_destroy: true

  has_many :components, dependent: :destroy
  accepts_nested_attributes_for :components, allow_destroy: true

  has_one_attached :cover, dependent: :destroy
end