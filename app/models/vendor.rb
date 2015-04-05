class Vendor < ActiveRecord::Base
  belongs_to :user
  has_many :items
  has_many :administrators, through: :vendor_administrations

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :slug, uniqueness: true

  before_validation :generate_slug

  def generate_slug
    self.slug = name.parameterize
  end

  def administrated_by?(user)
    user.superadmin? || administrators.include?(user)
  end
end
