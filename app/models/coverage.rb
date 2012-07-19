class Coverage < ActiveRecord::Base
    
  has_many :flight_coverages
  attr_accessible :flight_coverages_attributes
  accepts_nested_attributes_for :flight_coverages, allow_destroy: true
  
  def total_premium
    total = 0
    flight_coverages.each do |fc|
      total += fc.premium
    end
    total
  end

  def total_coverage
    total = 0
    flight_coverages.each do |fc|
      total += fc.c240_or_more
    end
    total
  end

  
end
