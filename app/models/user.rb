class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :first_name, :last_name, :role, presence: true
  VALID_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:true, length: { maximum: 50 },
                    uniqueness: { case_sensitive: false }
  validates_format_of :email, with: VALID_REGEX, on: :create

  has_secure_password

  enum role: %w(default admin)

  has_many :orders
  has_many :vendors

  def full_name
    "#{first_name} #{last_name}"
  end
end
