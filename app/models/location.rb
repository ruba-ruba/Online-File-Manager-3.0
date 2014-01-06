class Location < ActiveRecord::Base
  attr_accessible :address, :latitude, :longitude, :item_id
  belongs_to :item
end
