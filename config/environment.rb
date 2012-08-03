# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Front::Application.initialize!

FLIGHTSTATS_GUID = "34b64945a69b9cac:-5b378c13:138494c0845:-45bd"

config.action_mailer.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
  :address  => "smtp.gmail.com",
  :port  => 587,
  :user_name  => "james@stylefuze.com",
  :password  => "1Mahustla",
  :authentication  => :login
}

config.action_mailer.raise_delivery_errors = true
