class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.belongs_to :address, foreign_key: true
      t.belongs_to :customer, foreign_key: true
      t.belongs_to :admin, foreign_key: true

      t.timestamps
    end
  end
end
