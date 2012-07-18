class ChangeCheckedToIntFightCoverage < ActiveRecord::Migration
  def change
    remove_column :flight_coverages, :checked
    add_column :flight_coverages, :checked, :integer
  end
end
