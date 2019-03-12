class CreateSystems < ActiveRecord::Migration[5.2]
  def change
    create_table :systems do |t|
      t.integer :name
      t.belongs_to :report, foreign_key: true
      t.timestamps
    end
  end
end
