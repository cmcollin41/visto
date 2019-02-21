class Address < ApplicationRecord
	extend FriendlyId
  friendly_id :long_address, use: :slugged

  has_many :jobs
  has_many :properties
  has_many :reports, inverse_of: :address
  
end
