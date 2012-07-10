class FlightSearch < ActiveRecord::Base

  belongs_to :main_search
  
  attr_accessible :main_search_id, 
                  :flight_number,
                  :departure_airport,
                  :arrival_airport,
                  :departure_time,
                  :_destroy
  
  
end

