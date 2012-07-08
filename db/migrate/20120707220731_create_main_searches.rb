class CreateMainSearches < ActiveRecord::Migration
  def change
    
    create_table :main_searches do |t|
      t.timestamps
    end

    add_column :flight_searches, :main_search_id, :integer

  end
end
