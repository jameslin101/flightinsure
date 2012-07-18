class FlightSearch < ActiveRecord::Base

  belongs_to :main_search
  
  attr_accessible :flight_number,
                  :departure_date,
                  :origin,
                  :destination
  
  # validates :flight_number, :format => { :with => /^[a-zA-Z]{2}\s?\d{2,4}$/, 
  #                                        :message => "Invalid format"}
  # validates :departure_date, :format => { :with => /^\d{2}\/\d{2}\/\d{4}$/,
  #                                         :message => "Must be MM/DD/YYYY format"}
  # 
end

