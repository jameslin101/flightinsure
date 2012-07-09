class FlightLeg < ActiveRecord::Base

  has_one :flight_id_carrier, :operator_carrier, :departure_airport, :arrival_airport, :equipment
end
