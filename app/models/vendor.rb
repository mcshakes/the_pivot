class Vendor < ActiveRecord::Base
  belongs_to :user
  has_many :items

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :slug, uniqueness: true

  before_validation :generate_slug

  def generate_slug
    self.slug = name.parameterize
  end
end
