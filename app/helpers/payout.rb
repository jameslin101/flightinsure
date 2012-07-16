module Payout
  
  def Payout.get_premiums
    ["$4.99","$9.99","$14.99","$19.99","$24.99"]
  end
  
  def Payout.get_payouts (premium)
    payouts = {"c1" => get_coverage(premium,"c1"),
               "c2" => get_coverage(premium,"c2"),
               "c3" => get_coverage(premium,"c3"),
               "c4" => get_coverage(premium,"c4"),
               "cc" => get_coverage(premium,"cc")
              }
  end
    
  
  def Payout.get_coverage(premium,delay_type)
    p = premium.to_f
    return_val = 0
    case delay_type
    when "c1"
      return_val = (p * 3).round(-1)
    when "c2"
      return_val = (p * 6).round(-1)
    when "c3"
      return_val = (p * 10).round(-1)
    when "c4"
      return_val = (p * 16).round(-1)
    when "cc"
      return_val = (p * 8).round(-1)
    end
    "$" + return_val.to_s
    
  end
  
end
                
                