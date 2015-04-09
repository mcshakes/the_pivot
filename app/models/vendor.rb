class Vendor < ActiveRecord::Base
  belongs_to :user
  has_many :items
  # has_many :administrators, through: :vendor_administrations

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :credit_card, presence: true, length: { minimum: 15} #, maximum: 16}
  validates :slug, uniqueness: true

  before_validation :generate_slug
  before_validation :clean_credit_card_number

  scope :with_items, -> {joins(:items).where.not(items: {vendor: nil})}

  def generate_slug
    self.slug = name.parameterize
  end

  def clean_credit_card_number
    self.credit_card.gsub(/[^0-9]/, "")
  end

  def administrated_by?(user)
    user.superadmin? || administrators.include?(user)
  end
end
