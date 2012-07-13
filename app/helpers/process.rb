module Process

  #query_hash = {:departure_date => departure_date,
  #              :origin_airport_code => origin_airport_code,
  #              :destination_airport_code => destination_airport_code,
  #              :airline_code => airline_code,
  #              :flight_number => flight_number}
  
  def Process.getVal(node,attrib)
    if node.attribute(attrib)
      node.attribute(attrib).value
    else
      "WARNING DATA MISSING"
    end
  end

  def Process.process_query(pq,query_hash)
    #query_result = QueryResult.new
    #query_result.query_hash = query_hash
    qr = Nokogiri::XML(pq)
    qr.remove_namespaces!
    # qr.xpath("//Flight").each do |f|
    #   flight = FlightCls.new
    #   flight.arrival_date_adjustment = getVal(f,"ArrivalDateAdjustment")
    #   flight.arrival_time = getVal(f,"ArrivalTime")
    #   flight.departure_time = getVal(f,"DepartureTime")
    #   flight.departure_date_to = getVal(f,"DepartureDateTo")
    #   flight.departure_days_of_week = getVal(f,"DepartureDaysOfWeek")
    #   flight.departure_time = getVal(f,"DepartureTime")
    #   flight.distance_miles = getVal(f,"DistanceMiles")
    #   flight.flight_duration_minutes = getVal(f,"FlightDurationMinutes")
    #   flight.flight_type = getVal(f,"FlightType")
    #   flight.layover_duration_minutes = getVal(f,"LayoverDurationMinutes")
    #   flight.service_type = getVal(f,"ServiceType")
    #   flight.departure_airport = process_airport(f.xpath("DepartureAirport"))
    #   flight.arrival_airport = process_airport(f.xpath("ArrivalAirport"))
    #   f.xpath("FlightLeg").each do |l|
    #     flight.flight_legs << process_flight_leg(l,query_hash)
    #   end
    #   query_result.flights << flight
    # end
    # query_result
    legs = []
    qr.xpath("//FlightLeg").each do |l|
      legs << process_flight_leg(l,query_hash)
    end
    legs
    
  end

  def Process.process_airport(a)
    airport = Airport.find_by_airport_code(getVal(a,"AirportCode"))
    if !airport then
      airport = Airport.new
      airport.airport_code = getVal(a,"AirportCode")
      airport.city = getVal(a,"City")
      airport.country_code = getVal(a,"CountryCode")
      airport.faa_code = getVal(a,"FAACode")
      airport.iata_code = getVal(a,"IATACode")
      airport.icao_code = getVal(a,"ICAOCode")
      airport.name = getVal(a,"Name")
      airport.state_code = getVal(a,"StateCode")
      airport.save
    end  
    airport
  end 

  def Process.process_flight_leg(l,query_hash)
    leg = FlightLeg.new
    leg.codeshare = getVal(l,"Codeshare").to_bool
    leg.arrival_date_adjustment = getVal(l,"ArrivalDateAdjustment").to_i
    leg.arrival_terminal = getVal(l,"ArrivalTerminal")
    
    o_date = query_hash[:departure_date]
    ap query_hash
    ap o_date
    
    a_hour = Time.parse(getVal(l,"ArrivalTime")).hour
    a_min = Time.parse(getVal(l,"ArrivalTime")).min    
    a_date = o_date + leg.arrival_date_adjustment.days
    leg.arrival_time = DateTime.new(a_date.year, 
                                    a_date.month,
                                    a_date.day,
                                    a_hour,
                                    a_min)

    leg.departure_date_adjustment = getVal(l,"DepartureDateAdjustment").to_i
    leg.departure_terminal = getVal(l,"DepartureTerminal")
    
    d_hour = Time.parse(getVal(l,"DepartureTime")).hour
    d_min = Time.parse(getVal(l,"DepartureTime")).min    
    d_date = o_date + leg.departure_date_adjustment.days
    
    leg.departure_time = DateTime.new(d_date.year, 
                                      d_date.month,
                                      d_date.day,
                                      d_hour,
                                      d_min) 
    
    leg.distance_miles = getVal(l,"DistanceMiles").to_i
    leg.flight_duration_minutes = getVal(l,"FlightDurationMinutes").to_i
    leg.layover_duration_minutes = getVal(l,"LayoverDurationMinutes").to_i
    leg.wetlease_info = getVal(l,"WetleaseInfo")
    leg.flightid_flight_number = getVal(l.xpath("FlightId"),"FlightNumber").to_i
    leg.flightid_carrier = process_carrier(l.xpath("FlightId/Carrier"))
    if l.xpath("Operator").length > 0
      leg.operator_flight_number = getVal(l.xpath("Operator"),"FlightNumber").to_i
      leg.operator_carrier = process_carrier(l.xpath("Operator/Carrier"))
    end
    leg.departure_airport = process_airport(l.xpath("DepartureAirport"))
    leg.arrival_airport = process_airport(l.xpath("ArrivalAirport"))
    leg.equipment = process_equipment(l.xpath("Equipment"))
    leg
  end                  

  def Process.process_carrier(c)
    carrier = Carrier.find_by_airline_code(getVal(c,"AirlineCode"))
    if !carrier then
      carrier = Carrier.new
      carrier.airline_code = getVal(c,"AirlineCode")
      carrier.iata_code = getVal(c,"IATACode")
      carrier.icao_code = getVal(c,"ICAOCode")
      carrier.name = getVal(c,"Name")
      carrier.save
    end
    carrier
  end

  def Process.process_equipment(e)
    equipment = Equipment.find_by_aircraft_type_code(getVal(e,"AircraftTypeCode"))
    if !equipment then
      equipment = Equipment.new
      equipment.aircraft_type_code = getVal(e,"AircraftTypeCode")
      equipment.aircraft_type_name = getVal(e,"AircraftTypeName")
      equipment.jet = getVal(e,"Jet").to_bool
      equipment.regional = getVal(e,"Regional").to_bool
      equipment.turboprop = getVal(e,"Turboprop").to_bool
      equipment.wide_body = getVal(e,"WideBody").to_bool
      equipment.save
    end
    equipment
  end
end