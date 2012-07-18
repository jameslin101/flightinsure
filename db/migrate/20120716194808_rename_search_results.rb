class RenameSearchResults < ActiveRecord::Migration
  def change

    rename_table :search_results, :flight_coverages

  end

end
