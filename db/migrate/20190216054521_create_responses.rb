class CreateResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :responses do |t|
      t.belongs_to :report, foreign_key: true
      t.integer :question_id
      t.integer :choice_id

      t.timestamps
    end
  end
end
