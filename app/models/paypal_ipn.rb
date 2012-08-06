class PaypalIpn < ActiveRecord::Base

  has_many :paypal_transactions

  attr_accessible :action_type, 
                  :cancel_url,
                  :charset,
                  :fees_payer, 
                  :ipn_notification_url, 
                  :log_default_shipping_address_in_transaction, 
                  :notify_version, 
                  :pay_key, 
                  :payment_request_date, 
                  :paypal_transaction_id, 
                  :return_url, 
                  :reverse_all_parallel_payments_on_error, 
                  :sender_email, 
                  :status, 
                  :test_ipn, 
                  :transaction_type, 
                  :verify_sign,
                  :paypal_transaction_attributes

end
