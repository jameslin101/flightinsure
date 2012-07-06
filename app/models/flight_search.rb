class FlightSearch < ActiveRecord::Base
  include FlightStats

  attr_accessible :flight_number, :departure_airport, :arrival_airport, :departure_time
  
  
end

