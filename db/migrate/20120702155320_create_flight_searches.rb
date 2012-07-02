class CreateFlightSearches < ActiveRecord::Migration
  def change
    create_table :flight_searches do |t|
      t.string :departure_airport
      t.string :arrival_airport
      t.string :airline_code
      t.integer :flight_number
      t.datetime :departure_time
      t.datetime :arrival_time

      t.timestamps
    end
  end
end
