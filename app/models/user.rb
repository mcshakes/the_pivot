class User < ActiveRecord::Base
  include CacheInvalidator

  validates :first_name, :last_name, :role, :email, presence: true
  before_save { self.email = email.downcase }
  VALID_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:true, length: { maximum: 50 },
                    uniqueness: { case_sensitive: false }
  validates_format_of :email, with: VALID_REGEX, on: :create

  has_secure_password

  has_many :orders
  has_many :vendors
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :favorites
  has_many :favorite_items, through: :favorites, source: :item
  has_many :credit_cards
  has_many :addresses

  def full_name
    "#{first_name} #{last_name}"
  end

  def store_admin?(current_vendor)
    self.vendors.exists?(current_vendor.id)
  end

  def has_this_favorite?(item)
    favorite_items.include?(item)
  end     
end


