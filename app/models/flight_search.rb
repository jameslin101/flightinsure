class FlightSearch < ActiveRecord::Base
  attr_accessible :flight_number, :departure_airport, :arrival_airport, :departure_time
end

