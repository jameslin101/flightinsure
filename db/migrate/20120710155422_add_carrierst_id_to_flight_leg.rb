class AddCarrierstIdToFlightLeg < ActiveRecord::Migration
  def change
    add_column :flight_legs, :flightid_carrier_id, :integer

    add_column :flight_legs, :operator_carrier_id, :integer

  end
end
