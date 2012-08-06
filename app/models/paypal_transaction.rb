class PaypalTransaction < ActiveRecord::Base

  belongs_to :paypal_ipn

  attr_accessible :amount, 
                  :id_for_paypal_transaction, 
                  :id_for_sender_txn, 
                  :is_primary_receiver, 
                  :paymentType, 
                  :paypal_ipn_id, 
                  :pending_reason, 
                  :receiver, 
                  :status, 
                  :status_for_sender_txn
                  
end
