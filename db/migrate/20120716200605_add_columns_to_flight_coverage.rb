class AddColumnsToFlightCoverage < ActiveRecord::Migration
  def change
    add_column :flight_coverages, :premium, :float

    add_column :flight_coverages, :c60_120, :float

    add_column :flight_coverages, :c120_180, :float

    add_column :flight_coverages, :c180_240, :float

    add_column :flight_coverages, :c240_or_more, :float

    add_column :flight_coverages, :cc, :float

    add_column :flight_coverages, :check, :boolean

  end
end
