class ChangeResponseQuestionIdType < ActiveRecord::Migration[5.2]
  def change
  	change_column :responses, :question_id, :bigint
  	add_index :responses, :question_id
  	add_foreign_key :responses, :questions
  end
end
