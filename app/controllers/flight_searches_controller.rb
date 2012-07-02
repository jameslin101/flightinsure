class FlightSearchesController < ApplicationController
  
  def new
    @flight_search = FlightSearch.new(params[:id])
  end
  
end
