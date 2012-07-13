class FlightLeg < ActiveRecord::Base

  attr_accessible :codeshare,
                  :arrival_date_adjustment,
                  :arrival_terminal,
                  :arrival_time,
                  :departure_date_adjustment,
                  :departure_terminal,
                  :departure_time,
                  :distance_miles,
                  :flight_duration_minutes,
                  :layover_duration_minutes,
                  :wetlease_info,
                
                  :flight_id_flight_number,
                  :flight_id_carrier,
                  :operator_flight_number,
                  :operator_carrier,
                  :departure_airport,
                  :arrival_airport,
                  :equipment
              
                  
                  
  belongs_to :departure_airport, :class_name => "Airport"
  belongs_to :arrival_airport, :class_name => "Airport"
  belongs_to :flightid_carrier, :class_name => "Carrier"
  belongs_to :operator_carrier, :class_name => "Carrier"
  belongs_to :equipment
  belongs_to :search_result

end
