class MainSearchesController < ApplicationController
  require "process"
  
  TESTMODE = true
  
  def new
    @main_search = MainSearch.new
    2.times {@main_search.flight_searches.build}
  end  

  def create
    puts params.inspect
    @main_search = MainSearch.new(params["main_search"])
    if @main_search.save
      legs = []

      @main_search.flight_searches.each do |s|
        if (s.flight_number.blank? or 
           s.departure_date.blank? or
           s.origin.blank? or
           s.destination.blank?) then
              ap s
              puts "FLIGHT SEARCH DESTROYED"
              s.destroy
        else
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
                                    "origin.airportCode"=>origin,
                                    "destination.airportCode"=>destination,
                                    "flightType"=>"NONSTOP"}
                                  
                            ap flightstats_query_hash
          #more logical representation of user inputs to be passed on to query_results processing
          query_hash = {:departure_date => o_date,
                        :airline_code => airline_code,
                        :flight_number => flight_number}              

          if !TESTMODE then
            q = FlightStats.query(flightstats_query_hash)
        
          legs += Process::process_query(q,query_hash)
          end
        end
      end
      
      if TESTMODE then
        #q=FlightStats.query({"Service"=>"SchedulesConnectionsService","from"=>"2012-08-01T00:00","to"=>"2012-08-01T23:59","carriers[0].airlineCode"=>"AA","flightNumber"=>"1442","origin.airportCode"=>"LAX","destination.airportCode"=>"EWR","flightType"=>"NONSTOP"})
        
        fake_query_hash = {:departure_date => DateTime.new(2012,12,1),
                           :airline_code => "XX",
                           :flight_number => "99999"}
        legs = []
        legs += Process::process_query(File.read("xml/SJC.xml"), fake_query_hash)
        legs += Process::process_query(File.read("xml/BOS.xml"), fake_query_hash)
        legs += Process::process_query(File.read("xml/CLE.xml"), fake_query_hash)
        legs += Process::process_query(File.read("xml/DCA.xml"), fake_query_hash)
        #ap @query_results.length
      end
        
      @coverage = Coverage.new
      legs.each do |l|
          @coverage.flight_coverages << FlightCoverage.create(:flight_leg => l, :checked => 1)
      end
      @coverage.save
  
      redirect_to edit_coverage_path(@coverage)

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
