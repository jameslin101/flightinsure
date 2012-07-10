class AddEquipmentIdToFlightLeg < ActiveRecord::Migration
  def change
    add_column :flight_legs, :equipment_id, :integer

  end
end
