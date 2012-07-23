class OrdersController < ApplicationController

  before_filter :authenticate_user!
  
  def new
    if session[:coverage_id]
      @coverage = Coverage.find_by_id(session[:coverage_id])
    else
      flash[:error] = "No coverage found."
      redirect_to root_path
    end

    @user = current_user    
    @order = Order.new(params[:id])
    @order.user_id = current_user.id
  end
  
  def show
    @order = Order.find(params[:id])
    @coverage = @order.coverage
  end
  
  def create
    if session[:coverage_id]
      @coverage = Coverage.find_by_id(session[:coverage_id])
    end
    #raise params.inspect
    @user = current_user
    @order = Order.new(params[:id])
    @order.coverage_id = @coverage.id
    @order.user_id = current_user.id
    @order.user.update_attributes(params[:order][:user])
    @order.user.save
    
    if @order.save_with_payment
      @order.paid = true
      @order.save
      redirect_to @order
    else
      render :action => "new"
    end
  end
  
  def edit
  end
  
  def update
  end
  
end
