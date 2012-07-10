class Carrier < ActiveRecord::Base
  
  attr_accessible :airline_code,
                  :iata_code,
                  :icao_code,
                  :name
  
  belongs_to :carrierable, :polymorphic => true
  
end
