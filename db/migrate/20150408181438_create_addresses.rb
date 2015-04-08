class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.text :type
      
      t.text :street
      t.text :city
      t.text :state
      t.text :integer
      t.text :country
      t.timestamps null: false
    end
  end
end
