module Payout
  
  def Payout.get_premiums
    [4,9,14,19,24]
  end
  
  def Payout.get_payouts (premium)
    puts "ASDFASFSADF:" + premium.to_s
    payouts = {"c1" => get_coverage(premium,"c1"),
                "c2" => get_coverage(premium,"c2"),
                "c3" => get_coverage(premium,"c3"),
                "c4" => get_coverage(premium,"c4"),
                "cc" => get_coverage(premium,"cc")
                }
  end
    
  
  def Payout.get_coverage(premium,delay_type)
    case delay_type
    when "c1"
      (premium * 3).round(-1)
    when "c2"
      (premium * 6).round(-1)
    when "c3"
      (premium * 10).round(-1)
    when "c4"
      (premium * 16).round(-1)
    when "cc"
      (premium * 8).round(-1)
    end
  end
  
end
                
                
            
      
#  ="0" ArrivalTime="21:30" DepartureDateFrom="2012-07-02" DepartureDateTo="2012-08-20" DepartureDaysOfWeek="123457" DepartureTime="18:30" DistanceMiles="718" FlightDurationMinutes="120" FlightType="NON_STOP" LayoverDurationMinutes="0" ServiceType="PASSENGER_ONLY">