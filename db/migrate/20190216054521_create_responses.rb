class CreateResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :responses do |t|
    	t.text :response
      t.belongs_to :report, foreign_key: true
      t.belongs_to :question, foreign_key: true
      t.integer :choice_id

      t.timestamps
    end
  end
end
