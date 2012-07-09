class MainSearchesController < ApplicationController
  require "process"
  
  def new
    @main_search = MainSearch.new
    2.times {@main_search.flight_searches.build}
  end  

  def create
    @main_search = MainSearch.create(params["main_search"])
    if @main_search.save
      @query_results = []
      ap @main_search
      search_results(@main_search,@query_results)
  
    else
      render :action => :new
    end
  end
  
  def search_results(ms, qr)
    @query_results = qr
    @main_search = ms
    @main_search.flight_searches.each do |s|
      origin_airportCode = s.departure_airport
      destination_airportCode = s.arrival_airport
      airlineCode = s.flight_number.scan(/^[a-zA-Z]{2}/)[0]
      flightNumber = s.flight_number.scan(/\d+$/)[0]
      departure_date = s.departure_time.strftime("%Y-%m-%dT%H:%M")
      arrival_date = s.departure_time.end_of_day().strftime("%Y-%m-%dT%H:%M")
      
      p "ASDFSAFSAFSDFAS: " + s.to_s
      #q =  FlightStats.query({"Service"=>"SchedulesConnectionsService","from"=>from,"to"=>to,"origin.airportCode"=>origin_airportCode,"destination.airportCode"=>destination_airportCode})
      query_hash = {"Service"=>"SchedulesConnectionsService",
                    "from"=>departure_date,
                    "to"=>arrival_date,
                    "origin.airportCode"=>origin_airportCode,
                    "destination.airportCode"=>destination_airportCode,
                    "flightNumber"=>flightNumber}
      q = FlightStats.query(query_hash)
      #q =FlightStats.query({"Service"=>"SchedulesConnectionsService","from"=>"2012-07-04T12:00","to"=>"2012-07-04T12:15","origin.airportCode"=>"CLE","destination.airportCode"=>"PIT"})
      #q = 
      #ap s
      @query_results << Process::process_query(q,query_hash)
    end
    #@query_results << Process::process_query(File.read("PIT.xml"), Date.new(2012,9,9))
    #@query_results << Process::process_query(File.read("EWR.xml"), Date.new(2012,9,9))
    #ap @query_results.length
    render :create
  end
  

  
  def show
    @main_search = MainSearch.find(params[:id])
  end
end
