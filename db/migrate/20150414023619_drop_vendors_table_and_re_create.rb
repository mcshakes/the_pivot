class DropVendorsTableAndReCreate < ActiveRecord::Migration
  def change
    drop_table :vendors
    
    create_table :vendors do |t|
      t.text    "name"
      t.integer "user_id"
      t.text    "description"
      t.text    "slug"
      t.text    "credit_card"

      t.timestamps null: false
    end
  end
end
