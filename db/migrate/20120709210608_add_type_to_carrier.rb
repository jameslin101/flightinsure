class AddTypeToCarrier < ActiveRecord::Migration
  def change
    add_column :carriers, :type, :string

  end
end
