class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :coverage
  has_many :paypal_ipns
  accepts_nested_attributes_for :user, :reject_if => lambda { |u| u[:last_name].blank?}
  attr_accessible :user_attributes, :paypal_ipn_attributes
  
  attr_accessor :stripe_card_token
  
  def save_with_stripe_payment
    if valid? 
      customer_id = user.stripe_customer_token
      #if customer_id.blank?
        customer = Stripe::Customer.create(description: user.email, card: stripe_card_token)
        customer_id = customer.id
        user.stripe_customer_token = customer.id
        #user.update_attributes(params[:user])
        user.save
      #end
      n = Stripe::Charge.create(
              :description => user.email,
              :amount => (coverage.total_premium*100).to_i,
              :currency => "usd",
              :customer => customer_id
              )
    end
    self.save
  end
   
  def confirm_payment
    self.paid_time = DateTime.now
    UserMailer.order_confirmation(self).deliver
    self.save
  end
 
  # rescue Stripe::CardError => e
  #   logger.error "Stripe CardError: #{e.message}"
  #    errors.add :base, "There was a problem with your credit card."
  #    user.stripe_customer_token = ""
  #    false
  # rescue Stripe::InvalidRequestError => e
  #   logger.error "Stripe Invalid Request Error: #{e.message}"
  #   errors.add :base, "There was a problem with your credit card."
  #   false
  # end
  
end
