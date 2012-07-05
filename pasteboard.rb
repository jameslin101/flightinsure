#FLIGHTSTATS_GUID = "34b64945a69b9cac:-5b378c13:138494c0845:-45bd"
#http://www.pathfinder-xml.com/development/xml?
Service=SchedulesConnectionsService

FlightStats.query({"Service"=>"SchedulesConnectionsService","from"=>"2012-07-04T12:00","to"=>"2012-07-04T12:15","origin.airportCode"=>"CLE","destination.airportCode"=>"PIT"})

xx = Nokogiri::XML(x)
xx.remove_namespaces!

e = ttt.xpath("//Flight//FlightLeg//FlightId//*[@AirlineCode]")[0].attr('AirlineCode')
e = ttt.xpath("//Flight//FlightLeg//FlightId//Carrier").attr('AirlineCode').value
 => "UA" 


doc=Nokogiri::XML(open("http://www.pathfinder-xml.com/development/xml?Service=SchedulesConnectionsService&login.guid=34b64945a69b9cac:-5b378c13:138494c0845:-45bd&origin.airportCode=ORD&destination.airportCode=EWR&from=2012-07-04T12:00&from=2012-07-04T12:15"))