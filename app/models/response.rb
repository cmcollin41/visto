class Response < ApplicationRecord
  belongs_to :report
  belongs_to :question, optional: true
  # has_many :items, dependent: :destroy
  # has_many :observations, dependent: :destroy
  has_many_attached :images, dependent: :destroy

  # accepts_nested_attributes_for :items, allow_destroy: true
  # accepts_nested_attributes_for :observations, allow_destroy: true

  enum observation: { no_observation: 0, material_defect: 1, major_defect: 2, minor_defect: 3, cosmetic_defect: 4, no_defect: 5 }
end
