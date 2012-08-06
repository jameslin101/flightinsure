class UserMailer < ActionMailer::Base
  default from: "james@stylefuze.com"

  def order_confirmation(order)
    @order = order
    user = @order.email
    mail to: user.email, subject: "Yes the order confirmation finally works!"
  end
  
  def user_confirmation(user)
    @user = user
    mail to: user.email, subject: "Yes the signup confirmation finally works!"
  end
end
