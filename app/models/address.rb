class Address < ActiveRecord::Base
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :country, presence: true

  belongs_to :user
end
