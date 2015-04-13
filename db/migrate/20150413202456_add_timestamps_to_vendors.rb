class AddTimestampsToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :created_at, :datetime
    add_column :vendors, :updated_at, :datetime
  end
end
