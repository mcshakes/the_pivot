class RemoveAddressesAndCreditCards < ActiveRecord::Migration
  def change
    remove_column :users, :shipping_address
    remove_column :users, :billing_address
    remove_column :users, :credit_card
  end
end
