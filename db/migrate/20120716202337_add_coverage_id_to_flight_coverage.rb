class AddCoverageIdToFlightCoverage < ActiveRecord::Migration
  def change
    add_column :flight_coverages, :coverage_id, :int

  end
end
