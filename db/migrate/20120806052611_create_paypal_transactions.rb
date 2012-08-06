class CreatePaypalTransactions < ActiveRecord::Migration
  def change
    create_table :paypal_transactions do |t|
      t.string :id_for_sender_txn
      t.string :receiver
      t.string :is_primary_receiver
      t.string :id
      t.string :status
      t.string :paymentType
      t.string :status_for_sender_txn
      t.string :pending_reason
      t.string :amount
      t.integer :paypal_ipn_id

      t.timestamps
    end
  end
end
