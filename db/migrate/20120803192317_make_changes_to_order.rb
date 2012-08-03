class MakeChangesToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :paid_time, :datetime
    remove_column :orders, :paid
    add_column :orders, :paypal_transactionid, :string
  end

end
