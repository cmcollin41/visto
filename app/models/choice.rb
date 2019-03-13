class Choice < ApplicationRecord
  belongs_to :question

  enum choice: {material_defect: 0, major_defect: 1, minor_defect: 2, cosmetic_defect: 3, no_defect: 4, no_observation: 5 }
end
