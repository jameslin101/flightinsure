class SearchResultsController < ApplicationController

  def show
    @search_results = SearchResult.find(params[:id])
  end
  
end