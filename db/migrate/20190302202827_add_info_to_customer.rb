class AddInfoToCustomer < ActiveRecord::Migration[5.2]
  def change
  	add_column :customers, :stripe_id, :string
    add_column :customers, :card_last4, :string
    add_column :customers, :card_type, :string
    add_column :customers, :card_exp_month, :integer
    add_column :customers, :card_exp_year, :integer
  end
end
