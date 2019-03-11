class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.belongs_to :response, foreign_key: true
      t.integer :kind
      t.string :number
      t.string :size
      t.integer :fuel_type
      t.text :notes

      t.timestamps
    end
  end
end
