class Location < ActiveRecord::Base
  attr_accessible :address, :latitude, :longitude
  after_validation :geocode, :if => :address_changed?

  belongs_to :item
end
