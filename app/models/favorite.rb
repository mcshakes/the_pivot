class Favorite < ActiveRecord::Base
  include CacheInvalidator

  belongs_to :user
  belongs_to :item
end
