class MainSearchesController < ApplicationController
  require "process"
  
  def new
    @main_search = MainSearch.new
    2.times {@main_search.flight_searches.build}
  end  

  def create
    @main_search = MainSearch.new(params["main_search"])
    if @main_search.save
      legs = []

      @main_search.flight_searches.each do |s|
        ap s
        airline_code = s.flight_number.scan(/^[a-zA-Z]{2}/)[0].upcase
        flight_number = s.flight_number.scan(/\d+$/)[0]
        
        o_date = Date.strptime(s.departure_date,"%m/%d/%Y")
        departure_date = o_date.strftime("%Y-%m-%dT%H:%M")
        to_date = o_date.end_of_day().strftime("%Y-%m-%dT%H:%M")
        origin = s.origin
        destination = s.destination
        
        flightstats_query_hash = {"Service"=>"SchedulesConnectionsService",
                                  "from"=>departure_date,
                                  "to"=>to_date,
                                  "flightNumber"=>flight_number,
                                  "carriers[0].airlineCode"=>airline_code,
                                  "origin"=>origin,
                                  "destination"=>destination,
                                  "flightType"=>"NONSTOP"}
                                  
                          ap flightstats_query_hash
        #more logical representation of user inputs to be passed on to query_results processing
        query_hash = {:departure_date => o_date,
                      :airline_code => airline_code,
                      :flight_number => flight_number}              

        #q = FlightStats.query(flightstats_query_hash)

        q=FlightStats.query({"Service"=>"SchedulesConnectionsService","from"=>"2012-08-01T00:00","to"=>"2012-08-01T23:59","carriers[0].airlineCode"=>"AA","flightNumber"=>"1442","origin.airportCode"=>"LAX","destination.airportCode"=>"EWR","flightType"=>"NONSTOP"})
         
        #q = 
        #ap s
        legs += Process::process_query(q,query_hash)
      end
      fake_query_hash = {:departure_date => DateTime.new(2012,12,1),
                         :airline_code => "XX",
                         :flight_number => "99999"}

      #legs += Process::process_query(File.read("SJC.xml"), fake_query_hash)
      #legs += Process::process_query(File.read("BOS.xml"), fake_query_hash)
      #legs += Process::process_query(File.read("CLE.xml"), fake_query_hash)
      #legs += Process::process_query(File.read("DCA.xml"), fake_query_hash)
      #ap @query_results.length
      @search_result = SearchResult.new
      legarray = []
      legs.each do |l|
        legstring = l.flightid_flight_number.to_s + l.departure_time.strftime("%I:%M%p") + 
                    l.departure_airport.airport_code + l.arrival_airport.airport_code
        ap legstring
        if legarray.find(legstring) then
          @search_result.flight_legs << l
          legarray << legstring
        end
      end
      @search_result.save
  
      redirect_to search_result_path(@search_result)
        
      #render search_results(@main_search,@query_results)
      #render :search_results
    else
      render :action => :new
    end
  end
  
  def search_results(ms, qr)
    @query_results = qr
    @main_search = ms

  end
  

  
  def show
    @main_search = MainSearch.find(params[:id])
  end
end
