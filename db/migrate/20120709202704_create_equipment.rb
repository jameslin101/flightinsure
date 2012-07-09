class CreateEquipment < ActiveRecord::Migration
  def change
    create_table :equipment do |t|
      t.string :aircraft_type_code
      t.string :aircraft_type_name
      t.boolean :jet
      t.boolean :regional
      t.boolean :turboprop
      t.boolean :wide_body

      t.timestamps
    end
  end
end
