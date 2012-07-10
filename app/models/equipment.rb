class Equipment < ActiveRecord::Base
  attr_accessible :aircraft_type_code,
                  :aircraft_type_name,
                  :jet,
                  :regional,
                  :turboprop,
                  :wide_body
                  
  has_many :flight_leg
end
