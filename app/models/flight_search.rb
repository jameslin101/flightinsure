class FlightSearch < ActiveRecord::Base

  belongs_to :main_search
  
  attr_accessible :flight_number,
                  :departure_date,
                  :origin,
                  :destination
  
  #validates :flight_number, :format => { :with => /^[a-zA-Z]{2}\s?\d{2,4}$/, 
  #                                       :message => "Must be 2 letters followed by 2-4 numbers, ie UA123"}

  
end

