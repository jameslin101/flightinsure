class FlightSearchesController < ApplicationController
  include FlightStats
  FLIGHTSTATS_GUID = "34b64945a69b9cac:-5b378c13:138494c0845:-45bd"
  
  def new
    @flight_search = FlightSearch.new(params[:id])
  end  

  def create
    @flight_search = FlightSearch.new(params[:flight_search])
    if @flight_search.save
      render :action => "search_results"
    else
      render :action => new
    end
  end
  
  def search_results
    @flight_search = FlightSearch.find(params[:id])
    origin_airportCode = @flight_search.departure_airport
    destination_airportCode = @flight_search.arrival_airport
    airlineCode = @flight_search.flight_number.scan(/^[a-zA-Z]{2}/)[0]
    flightNumber = @flight_search.flight_number.scan(/\d+$/)[0]
    from = @flight_search.departure_time.strftime("%Y-%m-%dT%H:%M")
    to = @flight_search.departure_time.end_of_day().
      end_of_hour.strftime("%Y-%m-%dT%H:%M")
    qr = FlightStats.query({"Service"=>"SchedulesConnectionsService","from"=>from,"to"=>to,"origin.airportCode"=>origin_airportCode,"destination.airportCode"=>destination_airportCode,"flightNumber"=>flightNumber})
    @query_results = process_query(pq)
      
  end
  
  def process_query(pq)
    qr = QueryResults.new
    query_ng = Nokogiri::XML(pq)
    query_ng.remove_namespaces!
    query_ng.xpath("//Flight").each do |f|
        flight = Flight.new
        flight.arrival_date_adjustment = f.attribute("ArrivalDateAdjustment").value
        flight.arrival_time = f.attribute("ArrivalTime").value
        flight.departure_time = f.attribute("DepartureTime").value
        flight.departure_date_to = f.attribute("DepartureDateTo").value
        flight.departure_days_of_week = f.attribute("DepartureDaysOfWeek").value
        flight.departure_time = f.attribute("DepartureTime").value
        flight.distance_miles = f.attribute("DistanceMiles").value
        flight.flight_duration_minutes = f.attribute("FightDurationMinutes").value
        flight.flight_type = f.attribute("FlightType").value
        flight.layover_duration_minutes = f.attribute("LayoverDurationMinutes").value
        flight.service_type = f.attribute("ServiceType").value
        flight.departure_airport = process_airport(f.xpath("DepartureAirport"))
        flight.arrival_airport = process_airport(f.xpath("ArrivalAirport"))
        f.xpath("FlightLeg").each do |l|
          flight.flight_legs << process_flight_leg(l)
        end
                      :flight_legs
  end
  
  def process_airport(a)
      airport = Airport.new
      airport.airport_code = a.attribute("AirportCode").value
      airport.city = a.attribute("City").value
      airport.country_code = a.attribute("CountryCode").value
      airport.faa_code = a.attribute("FAACode").value
      airport.iata_code = a.attribute("IATACode").value
      airport.icao_code = a.attribute("ICAOCode").value
      airport.name = a.attribute("Name").value
      airport.state_code = a.attribute("StateCode").value
      airport
  end                  

  def process_flight_leg(l)
      leg = FlightLeg.new
      leg.codeshare = l.attribute("CodeShare").value
      leg.arrival_date_adjustment = l.attribute("ArrivalDateAdjustment").value
      leg.arrival_terminal = l.attribute("ArrivalTerminal").value
      leg.arrival_time = l.attribute("ArrivalTime").value
      leg.departure_date_adjustment = l.attribute("DepartureDateAdjustment").value
      leg.departure_terminal = l.attribute("DepartureTerminal").value
      leg.departure_time = l.attribute("DepartureTime").value
      leg.distance_miles = l.attribute("DistanceMiles").value
      leg.flight_duration_minutes = l.attribute("FlightDurationMinutes").value
      leg.layover_duration_minutes = l.attribute("LayoverDurationMinutes").value
      leg.wetlease_info = l.attribute("WetleaseInfo").value
      leg.flight_id_flight_number = l.xpath("FlightId").attribute("FlightNumber").value
      leg.flight_id_carrier = process_carrier(l.xpath("FlightId/Carrier"))
      if l.xpath("Operator").length > 0
        leg.operator_flight_number = l.xpath("FlightId").attribute("FlightNumber").value
        leg.operator_carrier = process_carrier(l.xpath("Operator/Carrier"))
      end
      leg.departure_airport = process_airport(l.xpath("DepartureAirport"))
      leg.arrival_airport = process_airport(l.xpath("ArrivalAirport"))
      leg.equipment = process_equipment(l.xpath("Equipment"))
  end                  
  
  
  def show
    @flight_search = FlightSearch.find(params[:id])
  end
end
