class RenameSearchResultsToFlightCoverageInFlightLegs < ActiveRecord::Migration
  def change
    rename_column :flight_legs, :search_result_id, :flight_coverage_id
  end
end
