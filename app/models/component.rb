class Component < ApplicationRecord
  belongs_to :system
  has_many :observations, dependent: :destroy
  has_many :items, dependent: :destroy

  
  accepts_nested_attributes_for :items, allow_destroy: true
  accepts_nested_attributes_for :observations, allow_destroy: true

  enum name: { roof_covering: 0, gutters: 1, downspouts: 2 }
end
