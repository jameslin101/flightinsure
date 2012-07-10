class AddFaaCodeToAirport < ActiveRecord::Migration
  def change
    add_column :airports, :faa_code, :string

  end
end
