class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name, default: "default"
    end

    remove_column :users, :role
  end
end
