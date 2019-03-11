class Item < ApplicationRecord
  belongs_to :response

  enum kind: {water_heater: 0, heater: 10, compressor: 20, dishwasher: 30, wash_machine: 40, dryer: 45, refridgerator: 50, garbage_disposal: 60}
  enum fuel_type: {natural_gas: 0, propane: 10, electric: 20}
end
