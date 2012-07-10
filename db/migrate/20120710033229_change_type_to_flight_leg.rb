class ChangeTypeToFlightLeg < ActiveRecord::Migration
  def change
    rename_column :flight_legs, :flight_id_flight_number, :flightid_flight_number
  end
end
