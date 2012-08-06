class CreatePaypalIpns < ActiveRecord::Migration
  def change
    create_table :paypal_ipns do |t|
      t.string :payment_request_date
      t.string :return_url
      t.string :fees_payer
      t.string :ipn_notification_url
      t.string :sender_email
      t.string :verify_sign
      t.string :test_ipn
      t.integer :paypal_transaction_id
      t.string :cancel_url
      t.string :pay_key
      t.string :action_type
      t.string :transaction_type
      t.string :status
      t.string :log_default_shipping_address_in_transaction
      t.string :charset
      t.string :notify_version
      t.string :reverse_all_parallel_payments_on_error

      t.timestamps
    end
  end
end
