class Order < ActiveRecord::Base
  validates :user_id, presence: true
  has_many :item_orders
  has_many :items, through: :item_orders
  belongs_to :user

  def total_price
    items.inject(0) { |sum, item| sum + item.price }
  end

  def first_item_image
    items.first.image_file_name
  end

end
