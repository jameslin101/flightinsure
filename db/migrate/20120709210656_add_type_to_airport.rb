class AddTypeToAirport < ActiveRecord::Migration
  def change
    add_column :airports, :type, :string

  end
end
