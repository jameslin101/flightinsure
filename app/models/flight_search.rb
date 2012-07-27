class FlightSearch < ActiveRecord::Base

  belongs_to :main_search
  
  attr_accessible :flight_number,
                  :departure_date,
                  :origin,
                  :destination
  
  validates :flight_number, :format => { :with => /^[a-zA-Z]{2}\s?\d{2,4}$/, 
                                          :message => "Invalid format. Try airline code followed by flight number.", 
                                          :allow_blank => true}
                                          
  validates :departure_date, :format => { :with => /^\d{2}\/\d{2}\/\d{4}$/,
                                          :message => "Must be in MM/DD/YYYY format", 
                                          :allow_blank => true}
                                          
  validates :origin, :format => { :with => /^[a-zA-Z]{3}$/,
                                  :message => "Must enter airport code, which are 3 letters.", 
                                  :allow_blank => true}
                                  
  validates :destination, :format => { :with => /^[a-zA-Z]{3}$/,
                                       :message => "Must enter airport code, which are 3 letters.", 
                                       :allow_blank => true}
  
end

