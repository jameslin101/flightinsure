class Carrier < ActiveRecord::Base
  
  attr_accessible :airline_code,
                  :iata_code,
                  :icao_code,
                  :name
  
  has_and_belongs_to_many :flight_legs
    
end
