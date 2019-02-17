class Job < ApplicationRecord
  belongs_to :address
  belongs_to :customer, optional: true
end
