class MainSearch < ActiveRecord::Base
  attr_accessible :flight_searches_attributes
  has_many :flight_searches
  accepts_nested_attributes_for :flight_searches, allow_destroy: true, :reject_if => lambda { |a| a[:flight_number, :departure_airport, :arrival_airport, :departure_time]
end
