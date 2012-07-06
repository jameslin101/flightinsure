module Process

  def Process.process_query(pq)
    query_result = QueryResult.new
    qr = Nokogiri::XML(pq)
    qr.remove_namespaces!
    qr.xpath("//Flight").each do |f|
      flight = Flight.new
      flight.arrival_date_adjustment = f.attribute("ArrivalDateAdjustment").value
      flight.arrival_time = f.attribute("ArrivalTime").value
      flight.departure_time = f.attribute("DepartureTime").value
      flight.departure_date_to = f.attribute("DepartureDateTo").value
      flight.departure_days_of_week = f.attribute("DepartureDaysOfWeek").value
      flight.departure_time = f.attribute("DepartureTime").value
      flight.distance_miles = f.attribute("DistanceMiles").value
      flight.flight_duration_minutes = f.attribute("FlightDurationMinutes").value
      flight.flight_type = f.attribute("FlightType").value
      flight.layover_duration_minutes = f.attribute("LayoverDurationMinutes").value
      flight.service_type = f.attribute("ServiceType").value
      flight.departure_airport = Process.process_airport(f.xpath("DepartureAirport"))
      flight.arrival_airport = Process.process_airport(f.xpath("ArrivalAirport"))
      f.xpath("FlightLeg").each do |l|
        flight.flight_legs << Process::process_flight_leg(l)
      end
      query_result.flights << flight
    end
    query_result
  end

  def Process.process_airport(a)
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

  def Process.process_flight_leg(l)
    leg = FlightLeg.new
    leg.codeshare = l.attribute("Codeshare").value
    leg.arrival_date_adjustment = l.attribute("ArrivalDateAdjustment").value
    if l.attribute("ArrivalTerminal") then
      leg.arrival_terminal = l.attribute("ArrivalTerminal").value
    end
    leg.arrival_time = l.attribute("ArrivalTime").value
    leg.departure_date_adjustment = l.attribute("DepartureDateAdjustment").value
    if l.attribute("ArrivalTerminal") then
      leg.departure_terminal = l.attribute("DepartureTerminal").value
    end
    leg.departure_time = l.attribute("DepartureTime").value
    leg.distance_miles = l.attribute("DistanceMiles").value
    leg.flight_duration_minutes = l.attribute("FlightDurationMinutes").value
    leg.layover_duration_minutes = l.attribute("LayoverDurationMinutes").value
    leg.wetlease_info = l.attribute("WetleaseInfo").value
    leg.flight_id_flight_number = l.xpath("FlightId").attribute("FlightNumber").value
    leg.flight_id_carrier = Process.process_carrier(l.xpath("FlightId/Carrier"))
    if l.xpath("Operator").length > 0
      leg.operator_flight_number = l.xpath("FlightId").attribute("FlightNumber").value
      leg.operator_carrier = Process.process_carrier(l.xpath("Operator/Carrier"))
    end
    leg.departure_airport = Process.process_airport(l.xpath("DepartureAirport"))
    leg.arrival_airport = Process.process_airport(l.xpath("ArrivalAirport"))
    leg.equipment = Process.process_equipment(l.xpath("Equipment"))
  end                  

  def Process.process_carrier(c)
    carrier = Carrier.new
    carrier.airline_code = c.attribute("AirlineCode").value
    carrier.iata_code = c.attribute("IATACode").value
    carrier.icao_code = c.attribute("ICAOCode").value
    carrier.name = c.attribute("Name").value
    carrier
  end

  def Process.process_equipment(e)
    equipment = Equipment.new
    equipment.aircraft_type_code = e.attribute("AircraftTypeCode").value
    equipment.aircraft_type_name = e.attribute("AircraftTypeName").value
    equipment.jet = e.attribute("Jet").value
    equipment.regional = e.attribute("Regional").value
    equipment.turboprop = e.attribute("Turboprop").value
    equipment.wide_body = e.attribute("WideBody").value
    equipment
  end
end