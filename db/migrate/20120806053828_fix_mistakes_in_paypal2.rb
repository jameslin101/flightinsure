class FixMistakesInPaypal2 < ActiveRecord::Migration
  def change
    add_column :paypal_transactions, :id_for_paypal_transaction, :string
    add_column :orders, :paypal_ipn_id, :integer
  end
end
