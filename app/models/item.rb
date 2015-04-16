class Item < ActiveRecord::Base
  belongs_to :vendor

  has_many :item_categories
  has_many :categories, -> { uniq }, through: :item_categories
  has_many :item_orders
  has_many :orders, through: :item_orders

  scope :active_items, -> { where(status: "active").order_by_id }
  scope :retired_items, -> { where(status: "retired").order_by_id }

  validates :name, presence: true, uniqueness: true
  validates :description, :price, presence: true
  validates :price, numericality: { greater_than: 0 }

  before_validation :parameterize

  has_attached_file :image, styles: { large: "500x340>", medium: "250x170>", thumb: "100x100>" }, default_url: "aspen.jpg"
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def category_list
    categories.map(&:display_name).join(", ")
  end

  def to_param
    "#{name.parameterize}"
  end

  def parameterize
    return if name.nil?
    self.parameterized_name = name.parameterize
  end

  def display_name
    name.titleize
  end

  private

  def self.order_by_id
    order(:id).reverse
  end

end
