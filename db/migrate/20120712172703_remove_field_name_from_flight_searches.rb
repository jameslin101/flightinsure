class RemoveFieldNameFromFlightSearches < ActiveRecord::Migration
  def up
    remove_column :flight_searches, :departure_airport
        remove_column :flight_searches, :arrival_airport
        remove_column :flight_searches, :arrival_time
      end

  def down
    add_column :flight_searches, :arrival_time, :string
    add_column :flight_searches, :arrival_airport, :string
    add_column :flight_searches, :departure_airport, :string
  end
end
