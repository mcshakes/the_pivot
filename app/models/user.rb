class User < ActiveRecord::Base
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
  has_many :favorite_items
  has_many :items, through: :favorite_items

  def full_name
    "#{first_name} #{last_name}"
  end

  # def self.role
  #   role
  # end

  def registered_user?
    roles.exists?(name: "registered")
  end
end
