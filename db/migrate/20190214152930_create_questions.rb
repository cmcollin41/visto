class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.integer :system, default: 1
      t.string :component
      t.boolean :active, default: false, null: false 
      t.text :question

      t.timestamps
    end
  end
end
