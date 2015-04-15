class Vendor < ActiveRecord::Base
  include CacheInvalidator

  belongs_to :user
  has_many :items

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :credit_card, presence: true, length: { minimum: 15, maximum: 16}
  validates :slug, presence: true, uniqueness: true
  validates :user_id, presence: true

  before_validation :generate_slug
  before_validation :clean_credit_card_number

  scope :with_items, -> {joins(:items).where.not(items: {vendor: nil}).uniq}

  def generate_slug
    self.slug = name.parameterize
  end

  def clean_credit_card_number
    if credit_card
      credit_card.gsub!(/[^0-9]/, "")
    end
  end

  def administrated_by?(user)
    user.superadmin? || administrators.include?(user)
  end
end
