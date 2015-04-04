class User < ActiveRecord::Base
  validates :first_name, :last_name, :email, presence: true
  has_secure_password

  has_many :orders
  has_many :vendors
  has_many :user_roles
  has_many :roles, through: :user_roles

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
