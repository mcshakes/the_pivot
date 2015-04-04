class User < ActiveRecord::Base
  validates :first_name, :last_name, :email, :role, presence: true
  has_secure_password

  enum role: %w(default admin)

  has_many :orders
  has_many :vendors
  has_many :user_roles
  has_many :roles, through: :user_roles
  
  def full_name
    "#{first_name} #{last_name}"
  end
end
