class HopsController < ApplicationController

  before_filter :authorize
  
  def index
    @hops = current_user.hops
  end
  
  def show
    @hop = Hop.find(params[:id])
  end
  
end
