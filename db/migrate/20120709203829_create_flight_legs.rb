class CreateFlightLegs < ActiveRecord::Migration
  def change
    create_table :flight_legs do |t|
      t.boolean :codeshare
      t.integer :arrival_date_adjustment
      t.string :arrival_terminal
      t.datetime :arrival_time
      t.integer :departure_date_adjustment
      t.string :departure_terminal
      t.datetime :departure_time
      t.integer :distance_miles
      t.integer :flight_duration_minutes
      t.integer :layover_duration_minutes
      t.string :wetlease_info
      t.integer :flight_id_flight_number
      t.integer :operator_flight_number

      t.timestamps
    end
  end
end
