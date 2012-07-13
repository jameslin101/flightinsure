class AddSearchResultIdToFlightLeg < ActiveRecord::Migration
  def change
    add_column :flight_legs, :search_result_id, :integer

  end
end
