class CreateCarriers < ActiveRecord::Migration
  def change
    create_table :carriers do |t|
      t.string :airline_code
      t.string :iata_code
      t.string :icao_code
      t.string :name

      t.timestamps
    end
  end
end
