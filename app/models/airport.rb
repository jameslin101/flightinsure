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

  belongs_to :airportable, :polymorphic => true
  
  
end
