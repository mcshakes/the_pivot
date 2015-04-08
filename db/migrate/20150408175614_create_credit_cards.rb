class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|
      t.integer   :user_id
      t.text      :number
      t.timestamps null: false
    end
  end
end
