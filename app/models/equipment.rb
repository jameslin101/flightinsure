class Equipment < ActiveRecord::Base
  attr_accessible :aircraft_type_code,
                  :aircraft_type_name,
                  :jet,
                  :regional,
                  :turboprop,
                  :wide_body
                  
  has_and_belongs_to_many :flight_legs
end
