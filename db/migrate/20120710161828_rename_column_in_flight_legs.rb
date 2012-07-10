class RenameColumnInFlightLegs < ActiveRecord::Migration
  def change
    rename_column :flight_legs, :departure_aiport_id, :departure_airport_id
  end
end
