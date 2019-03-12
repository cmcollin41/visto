class CreateComponents < ActiveRecord::Migration[5.2]
  def change
    create_table :components do |t|
      t.belongs_to :system, foreign_key: true
      t.integer :name
      

      t.timestamps
    end
  end
end
