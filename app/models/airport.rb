class Airport < ActiveRecord::Base
  
  attr_accessible :airport_code,
                  :city,
                  :country_code,
                  :iata_code,
                  :icao_code,
                  :name,
                  :state_code,
                  :faa_code
                  
  before_validation :wtf
  
  def wtf
    "wtf"
  end

  has_and_belongs_to_many :flight_legs
  
  
end
