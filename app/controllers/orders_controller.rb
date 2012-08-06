class OrdersController < ApplicationController

  protect_from_forgery :except => [:payment_notification]
  
  before_filter :authenticate_user!, :except =>[:payment_notification]
  
  def new
    if session[:coverage_id]
      @coverage = Coverage.find_by_id(session[:coverage_id])
    else
      flash[:error] = "No coverage found."
      redirect_to root_path
    end
    @order = Order.new(params[:id])
    @order.user_id = current_user.id
    @user = current_user    
  end
  
  def show
    @order = Order.find(params[:id])
    @coverage = @order.coverage
  end
  
  def create
    @order = Order.new(params[:id])
    @order.user_id = current_user.id
    
    if session[:coverage_id]
      @coverage = Coverage.find_by_id(session[:coverage_id])
    end
    @order.coverage_id = @coverage.id
    #raise params.inspect
    @user = current_user
    #@order.user.update_attributes(params[:order][:user])
    #@order.user.save
    @order.stripe_card_token = params[:order][:stripe_card_token]
    if @order.save_with_strip_payment
      @order.confirm_payment
      redirect_to @order
    else
      render :action => "new"
    end
  rescue Stripe::StripeError => e
    flash[:payment_error] = e.message
    logger.error e.message
    @user.errors.add :base, "There was a problem with your credit card"
    @user.stripe_customer_token = nil
    render :action => :new
    
  end
  

  def paypal_checkout
    
    @order = Order.new(params[:id])
    @order.user_id = current_user.id
    
    if session[:coverage_id]
      @coverage = Coverage.find_by_id(session[:coverage_id])
    end
    @order.coverage_id = @coverage.id
    @user = current_user
    @order.save
    
    pay_request = PaypalAdaptive::Request.new
    data = {
      "returnUrl" => order_url(@order),
      "requestEnvelope" => {"errorLanguage" => "en_US"},
      "currencyCode" => "USD",
      "receiverList" =>
              { "receiver" => [
                {"email" => "seller_1343843848_biz@gmail.com", "amount"=> @coverage.total_premium}
              ]},
      "cancelUrl" => new_order_url,
      "actionType" => "PAY",
      "ipnNotificationUrl" => paypal_payment_notification_url(@order.id)
    }

    #To do chained payments, just add a primary boolean flag:{“receiver”=> [{"email"=>"PRIMARY", "amount"=>"100.00", "primary" => true}, {"email"=>"OTHER", "amount"=>"75.00", "primary" => false}]}

    pay_response = pay_request.pay(data)

    if pay_response.success?
        # Send user to paypal
        redirect_to pay_response.approve_paypal_payment_url
    else
        puts pay_response.errors.first['message']
        redirect_to "/", notice: pay_response.errors.inspect
    end
  
  end
  
  def payment_notification
    ipn = PaypalAdaptive::IpnNotification.new
    ipn.send_back(request.raw_post)
    
    if ipn.verified?
      logger.info "Paypal IPN verified."
      #push Paypal ipn values into models
      ipn_hash = params.clone
      ipn_hash.delete("order_id")
      ipn_hash.delete("transaction")
      ipn = PaypalIpn.create(ipn_hash)
      txns_hash = params["transaction"]
      txns_hash.each_value do |txn_hash|
        txn_hash[".id_for_paypal_transaction"] = txn_hash[".id"]
        txn_hash.delete(".id")
        txn_hash.keys.each do |key| 
          txn_hash[key.sub(".","")] = txn_hash[key]
          txn_hash.delete(key)
        end
        ptxn = PaypalTransaction.create(txn_hash)
        ptxn.paypal_ipn_id = ipn.id
        ptxn.save
        logger.info ptxn.inspect
      end
      ipn.save
      logger.info ipn.inspect

      if params["status"] == "COMPLETED"
        logger.info "Going through order confirm status"
        @order = Order.find(params["order_id"])
        @order.paypal_ipn = ipn
        logger.info @order.inspect
        @order.confirm_payment
      end
    else
      logger.info "Waring: Paypal IPN not verified!"
    end

  end 
  
  def edit
  end
  
  def update
  end
  
  
end
