class Address < ApplicationRecord
	extend FriendlyId
  friendly_id :long_address, use: :slugged
end
