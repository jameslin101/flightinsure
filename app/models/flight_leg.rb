class FlightLeg < ActiveRecord::Base

  #has_one :flightid_carrier, :as :operator_carrier, :departure_airport, :arrival_airport, :equipment
  
  has_one :departure_airport, :class_name => "Airport"
  has_one :arrival_airport, :class_name => "Airport"
  has_one :flightid_carrier, :class_name => "Carrier"
  has_one :operator_carrier, :class_name => "Carrier"
  has_one :equipment
end
