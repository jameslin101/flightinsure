class SearchResult < ActiveRecord::Base
  
  has_many :flight_legs, :dependent => :destroy

end
