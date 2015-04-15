class Order < ActiveRecord::Base
  include CacheInvalidator

  validates :user_id, :status, presence: true
  has_many :item_orders
  has_many :items, through: :item_orders
  belongs_to :user

  scope :ordered, -> { where(status: "ordered") }
  scope :cancelled, -> { where(status: "cancelled") }
  scope :completed, -> { where(status: "completed") }

  def total_price
    items.inject(0) { |sum, item| sum + item.price }
  end
end
