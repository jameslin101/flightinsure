class DropAirlineCodeChangeFlightNumber < ActiveRecord::Migration
  def up
    remove_column :flight_searches, :airline_code
    remove_column :flight_searches, :flight_number
    add_column :flight_searches, :flight_number, :string
    
  end

  def down
    remove_column :flight_searches, :flight_number
    add_column :flight_searches, :airline_code, :string
    add_column :flight_searches, :flight_number, :string    
  end
end
