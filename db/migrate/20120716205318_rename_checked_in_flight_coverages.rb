class RenameCheckedInFlightCoverages < ActiveRecord::Migration
  def change
    rename_column :flight_coverages, :check, :checked
  end
end
