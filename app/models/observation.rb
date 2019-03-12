class Observation < ApplicationRecord
  belongs_to :response
  has_many_attached :images, dependent: :destroy

  enum defect: { no_observation: 0, material_defect: 1, major_defect: 2, minor_defect: 3, cosmetic_defect: 4, no_defect: 5 }
end
