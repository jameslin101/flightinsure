class AddAirlinesToFlightLeg < ActiveRecord::Migration
  def change
    add_column :flight_legs, :departure_aiport_id, :integer

    add_column :flight_legs, :arrival_airport_id, :integer

  end
end
