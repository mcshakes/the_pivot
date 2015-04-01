class CreateVendors < ActiveRecord::Migration
  def change
    create_table :vendors do |t|
      t.text :name
      t.integer :user_id
    end
  end
end
