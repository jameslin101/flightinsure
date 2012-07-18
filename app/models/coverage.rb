class Coverage < ActiveRecord::Base
    
  has_many :flight_coverages
  attr_accessible :flight_coverages_attributes
  accepts_nested_attributes_for :flight_coverages, allow_destroy: true
  
end
