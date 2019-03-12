class CreateObservations < ActiveRecord::Migration[5.2]
  def change
    create_table :observations do |t|
      t.string :name
      t.integer :defect, default: 0
      t.text :description
      t.belongs_to :component, foreign_key: true

      t.timestamps
    end
  end
end
