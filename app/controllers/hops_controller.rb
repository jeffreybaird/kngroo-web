class HopsController < ApplicationController

  before_filter :authorize
  
  def index
    if signed_in?
      @hops = Hop.includes(:venues).all - current_user.hops
    else
      @hops = Hop.includes(:venues).all
    end

    respond_to do |format|
      format.html
      format.json { render :json => @hops.to_json(:include => :venues) }
    end
  end
  
  def show
    @hop = Hop.includes(:venues).find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @hop.to_json(:include => :venues) }
    end
  end
  
end
