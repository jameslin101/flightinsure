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
      origin_airport_code = s.departure_airport
      destination_airport_code = s.arrival_airport
      airline_code = s.flight_number.scan(/^[a-zA-Z]{2}/)[0]
      flight_number = s.flight_number.scan(/\d+$/)[0]
      departure_date = s.departure_time.strftime("%Y-%m-%dT%H:%M")
      arrival_date = s.departure_time.end_of_day().strftime("%Y-%m-%dT%H:%M")
      
      #q =  FlightStats.query({"Service"=>"SchedulesConnectionsService","from"=>from,"to"=>to,"origin.airportCode"=>origin_airportCode,"destination.airportCode"=>destination_airportCode})
      flightstats_query_hash = {"Service"=>"SchedulesConnectionsService",
                                "from"=>departure_date,
                                "to"=>arrival_date,
                                "origin.airportCode"=>origin_airport_code,
                                "destination.airportCode"=>destination_airport_code,
                                "flightNumber"=>flight_number}
                                
      #more logical representation of user inputs to be passed on to query_results processing
      query_hash = {"departure_date" => departure_date,
                    "origin_airport_code" => origin_airport_code,
                    "destination_airport_code" => destination_airport_code,
                    "airline_code" => airline_code,
                    "flight_number" => flight_number}              
                    
      #q = FlightStats.query(flightstats_query_hash)
      #q =FlightStats.query({"Service"=>"SchedulesConnectionsService","from"=>"2012-07-04T12:00","to"=>"2012-07-04T12:15","origin.airportCode"=>"CLE","destination.airportCode"=>"PIT"})
      #q = 
      #ap s
      #@query_results << Process::process_query(q,query_hash)
    end
    fake_query_hash = {:departure_date => DateTime.new(2012,12,1),
                       :origin_airport_code => "AAA",
                       :destination_airport_code => "ZZZ",
                       :airline_code => "XX",
                       :flight_number => "99999"}
                  
    @query_results << Process::process_query(File.read("SJC.xml"), fake_query_hash)
    @query_results << Process::process_query(File.read("BOS.xml"), fake_query_hash)
    @query_results << Process::process_query(File.read("CLE.xml"), fake_query_hash)
    @query_results << Process::process_query(File.read("DCA.xml"), fake_query_hash)
    #ap @query_results.length
    render :create
  end
  

  
  def show
    @main_search = MainSearch.find(params[:id])
  end
end
