class HopsController < ApplicationController

  before_filter :authorize
  
  def index
    if signed_in?
      @hops = Hop.all - current_user.hops
    else
      @hops = Hop.all
    end

    respond_to do |format|
      format.html
      format.json { render :json => @hops }
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
