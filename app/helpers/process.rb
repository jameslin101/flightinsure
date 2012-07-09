module Process

  def Process.getVal(node,attrib)
    if node.attribute(attrib)
      node.attribute(attrib)
    else
      "WARNING DATA MISSING"
    end
  end

  def Process.process_query(pq,query_hash)
    query_result = QueryResult.new
    query_result.query_hash = query_hash
    qr = Nokogiri::XML(pq)
    qr.remove_namespaces!
    qr.xpath("//Flight").each do |f|
      flight = FlightCls.new
      flight.arrival_date_adjustment = getVal(f,"ArrivalDateAdjustment")
      flight.arrival_time = getVal(f,"ArrivalTime")
      flight.departure_time = getVal(f,"DepartureTime")
      flight.departure_date_to = getVal(f,"DepartureDateTo")
      flight.departure_days_of_week = getVal(f,"DepartureDaysOfWeek")
      flight.departure_time = getVal(f,"DepartureTime")
      flight.distance_miles = getVal(f,"DistanceMiles")
      flight.flight_duration_minutes = getVal(f,"FlightDurationMinutes")
      flight.flight_type = getVal(f,"FlightType")
      flight.layover_duration_minutes = getVal(f,"LayoverDurationMinutes")
      flight.service_type = getVal(f,"ServiceType")
      flight.departure_airport = process_airport(f.xpath("DepartureAirport"))
      flight.arrival_airport = process_airport(f.xpath("ArrivalAirport"))
      f.xpath("FlightLeg").each do |l|
        flight.flight_legs << process_flight_leg(l)
      end
      query_result.flights << flight
    end
    query_result
  end

  def Process.process_airport(a)
    airport = AirportCls.new
    airport.airport_code = getVal(a,"AirportCode")
    airport.city = getVal(a,"City")
    airport.country_code = getVal(a,"CountryCode")
    airport.faa_code = getVal(a,"FAACode")
    airport.iata_code = getVal(a,"IATACode")
    airport.icao_code = getVal(a,"ICAOCode")
    airport.name = getVal(a,"Name").value
    airport.state_code = getVal(a,"StateCode")
    airport
  end                  
  


  def Process.process_flight_leg(l)
    leg = FlightLegCls.new
    leg.codeshare = getVal(l,"Codeshare")
    leg.arrival_date_adjustment = getVal(l,"ArrivalDateAdjustment")
    leg.arrival_terminal = getVal(l,"ArrivalTerminal")
    leg.arrival_time = getVal(l,"ArrivalTime")
    leg.departure_date_adjustment = getVal(l,"DepartureDateAdjustment")
    leg.departure_terminal = getVal(l,"DepartureTerminal")
    leg.departure_time = getVal(l,"DepartureTime")
    leg.distance_miles = getVal(l,"DistanceMiles")
    leg.flight_duration_minutes = getVal(l,"FlightDurationMinutes")
    leg.layover_duration_minutes = getVal(l,"LayoverDurationMinutes")
    leg.wetlease_info = getVal(l,"WetleaseInfo")
    leg.flight_id_flight_number = getVal(l.xpath("FlightId"),"FlightNumber")
    leg.flight_id_carrier = process_carrier(l.xpath("FlightId/Carrier"))
    if l.xpath("Operator").length > 0
      leg.operator_flight_number = getVal(l.xpath("Operator"),"FlightNumber")
      leg.operator_carrier = process_carrier(l.xpath("Operator/Carrier"))
    end
    leg.departure_airport = process_airport(l.xpath("DepartureAirport"))
    leg.arrival_airport = process_airport(l.xpath("ArrivalAirport"))
    leg.equipment = process_equipment(l.xpath("Equipment"))
    leg
  end                  

  def Process.process_carrier(c)
    carrier = CarrierCls.new
    carrier.airline_code = getVal(c,"AirlineCode")
    carrier.iata_code = getVal(c,"IATACode")
    carrier.icao_code = getVal(c,"ICAOCode")
    carrier.name = getVal(c,"Name")
    carrier
  end

  def Process.process_equipment(e)
    equipment = EquipmentCls.new
    equipment.aircraft_type_code = getVal(e,"AircraftTypeCode")
    equipment.aircraft_type_name = getVal(e,"AircraftTypeName")
    equipment.jet = getVal(e,"Jet")
    equipment.regional = getVal(e,"Regional")
    equipment.turboprop = getVal(e,"Turboprop")
    equipment.wide_body = getVal(e,"WideBody")
    equipment
  end
end