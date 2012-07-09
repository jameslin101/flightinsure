class Flight
  
  def initialize
    @flight_legs = []
  end
  
  attr_accessor :departure_date,
                :arrival_date_adjustment,
                :arrival_time,
                :departure_time,
                :departure_date_to,
                :departure_days_of_week,
                :departure_time,
                :distance_miles,
                :flight_duration_minutes,
                :flight_type,
                :layover_duration_minutes,
                :service_type,
                
                :departure_airport,
                :arrival_airport,
                
                :flight_legs
end
                
                
            
      
#  ="0" ArrivalTime="21:30" DepartureDateFrom="2012-07-02" DepartureDateTo="2012-08-20" DepartureDaysOfWeek="123457" DepartureTime="18:30" DistanceMiles="718" FlightDurationMinutes="120" FlightType="NON_STOP" LayoverDurationMinutes="0" ServiceType="PASSENGER_ONLY">