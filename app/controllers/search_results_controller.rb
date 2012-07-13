class SearchResultsController < ApplicationController

  def show
    @search_results = SearchResult.find(params[:id])
  end
  
  def getpayouts
    puts "HELLO?" +params.to_s
    p = 13
    if params[:premium]
      p = params[:premium].to_i
    end
    @payouts = Payout.get_payouts(p)
    respond_to do |format|
        format.json  { render :json => @payouts.to_json }
    end
  end
end