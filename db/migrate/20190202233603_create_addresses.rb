class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :name
      t.string :long_address
      t.float :latitude
      t.float :longitude
      t.string :slug

      t.timestamps
    end

    add_index :addresses, :slug, unique: true
  end
end
