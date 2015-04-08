class AddCreditCardToUsers < ActiveRecord::Migration
  def change
    add_column :users, :credit_card, :text
  end
end
