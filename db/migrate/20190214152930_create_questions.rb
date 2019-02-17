class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.integer :section, default: 1
      t.boolean :active, default: false, null: false 
      t.text :question

      t.timestamps
    end
  end
end
