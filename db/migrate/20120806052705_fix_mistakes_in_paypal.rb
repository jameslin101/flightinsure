class FixMistakesInPaypal < ActiveRecord::Migration
  def change
    remove_column :paypal_ipns, :paypal_transaction_id
    remove_column :orders, :paypal_transactionid
  end
end
