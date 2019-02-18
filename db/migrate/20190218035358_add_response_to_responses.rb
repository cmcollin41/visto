class AddResponseToResponses < ActiveRecord::Migration[5.2]
  def change
    add_column :responses, :response, :text
  end
end
