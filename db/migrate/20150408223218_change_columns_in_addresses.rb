class ChangeColumnsInAddresses < ActiveRecord::Migration
  def change
    remove_column :addresses, :integer
    add_column    :addresses, :user_id, :integer
  end
end
