class AddDescriptionToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :description, :text
    add_column :vendors, :url, :text
  end
end
