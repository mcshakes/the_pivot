class RenameVendorUrlColumn < ActiveRecord::Migration
  def change
     rename_column :vendors, :url, :slug
   end
end
