class CreateSearchResults < ActiveRecord::Migration
  def change
    create_table :search_results do |t|

      t.timestamps
    end
  end
end
