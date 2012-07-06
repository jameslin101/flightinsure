class FlightSearchesController < ApplicationController
  require "process"
  
  def new
    @flight_search = FlightSearch.new(params[:id])
    @crap="nonsesne"
  end  

  def create
    @flight_search = FlightSearch.new(params[:flight_search])
    if @flight_search.save
      search_results(@flight_search)
    else
      render :action => :new
    end
  end
  
  def search_results(fs)
    @flight_search = fs
    origin_airportCode = @flight_search.departure_airport
    destination_airportCode = @flight_search.arrival_airport
    airlineCode = @flight_search.flight_number.scan(/^[a-zA-Z]{2}/)[0]
    flightNumber = @flight_search.flight_number.scan(/\d+$/)[0]
    from = @flight_search.departure_time.strftime("%Y-%m-%dT%H:%M")
    to = @flight_search.departure_time.end_of_day().strftime("%Y-%m-%dT%H:%M")
    #q = FlightStats.query({"Service"=>"SchedulesConnectionsService","from"=>from,"to"=>to,"origin.airportCode"=>origin_airportCode,"destination.airportCode"=>destination_airportCode,"flightNumber"=>flightNumber})
    #q =FlightStats.query({"Service"=>"SchedulesConnectionsService","from"=>"2012-07-04T12:00","to"=>"2012-07-04T12:15","origin.airportCode"=>"CLE","destination.airportCode"=>"PIT"})
    q = 
    @query_results = Process::process_query(File.read("PIT.xml"))
  end
  

  
  def show
    @flight_search = FlightSearch.find(params[:id])
  end
end
