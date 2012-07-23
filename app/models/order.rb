class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :coverage
  accepts_nested_attributes_for :user
  
  attr_accessor :stripe_card_token
  
  def save_with_payment
    if valid?
      customer_id = user.stripe_customer_token
      if customer_id.blank?
        customer = Stripe::Customer.create(description: user.email, card: stripe_card_token)
        customer_id = customer.id
        user.stripe_customer_token = customer.id
        user.save
      end
      
      #raise coverage.inspect
      Stripe::Charge.create(
              :description => user.email,
              :amount => (coverage.total_premium*100).to_i,
              :currency => "usd",
              :customer => customer_id
              )

    end 
  rescue Stripe::CardError => e
    logger.error "Stripe error while creating customer: #{e.message}"
     errors.add :base, "There was a problem with your credit card."
     user.stripe_customer_token = ""
     false
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end
  
end
