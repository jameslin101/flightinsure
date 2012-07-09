class CreateAirports < ActiveRecord::Migration
  def change
    create_table :airports do |t|
      t.string :airport_code
      t.string :city
      t.string :country_code
      t.string :iata_code
      t.string :icao_code
      t.string :name
      t.string :state_code

      t.timestamps
    end
  end
end
