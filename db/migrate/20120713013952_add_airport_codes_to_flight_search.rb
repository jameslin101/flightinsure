class AddAirportCodesToFlightSearch < ActiveRecord::Migration
  def change
    add_column :flight_searches, :origin, :string

    add_column :flight_searches, :destination, :string

  end
end
