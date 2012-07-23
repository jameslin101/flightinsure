class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :stripe_customer_token,
                  :address_1, :address_2, :city, :state, :zip_code
  
  has_many :coverages
  accepts_nested_attributes_for :coverages 
  # attr_accessible :title, :body

  
end
