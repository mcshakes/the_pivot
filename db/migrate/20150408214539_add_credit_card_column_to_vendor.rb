class AddCreditCardColumnToVendor < ActiveRecord::Migration
  def change
    add_column :vendors, :credit_card, :text
  end
end
