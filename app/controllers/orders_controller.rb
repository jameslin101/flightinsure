class OrdersController < ApplicationController

  before_filter :authenticate_user!
  
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
    if @order.save_with_payment
      @order.paid = true
      @order.save
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
  
  def edit
  end
  
  def update
  end
  
end
