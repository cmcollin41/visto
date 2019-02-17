class Property < ApplicationRecord
  belongs_to :address
  belongs_to :customer
end
