class CoverageController < ApplicationController

  def edit
    @coverage = Coverage.find(params[:id])
    #if @coverage.save()
      #raise params.inspect
      #render :action => "checkout"
    #end
  end

  def update
    @coverage = Coverage.find(params[:id])
    
    if @coverage.update_attributes(params[:coverage]) 
      @coverage.flight_coverages.each do |f|
        f.c60_120 = Payout.get_coverage(f.premium,"c1")
        f.c120_180 = Payout.get_coverage(f.premium,"c2")
        f.c180_240 = Payout.get_coverage(f.premium,"c3")
        f.c240_or_more = Payout.get_coverage(f.premium,"c4")
        f.cc = Payout.get_coverage(f.premium,"cc")
      end
      render :action => "checkout"
    else
      flash[:error] = ap(@service.errors.full_messages)
      render :action => "edit"
    end
  end
  
  def checkout
    @coverage = Coverage.find(params[:id])
  end
  
  def getpayouts
    if params[:premium]
      p = params[:premium].delete("$").to_f
    else
      p = 0
    end
    @payouts = Payout.get_payouts(p)
    respond_to do |format|
        format.json  { render :json => @payouts.to_json }
    end
  end
end