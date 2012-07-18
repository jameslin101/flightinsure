class FlightCoverage < ActiveRecord::Base
  
  has_one :flight_leg, :dependent => :destroy
  belongs_to :coverage
  attr_accessible :premium, 
                  :checked,
                  :flight_leg
  
  # after_save :destroy_unchecked
  # 
  # def destroy_unchecked
  #   if self.checked == 0
  #     self.destroy
  #   end
  # end
  
end
