class HopsController < ApplicationController

  before_filter :authorize
  
  def index
    if signed_in?
      @hops = Hop.includes(:venues).all - Assignment.active.where(:user_id => current_user.id).map(&:hop)
    else
      @hops = Hop.includes(:venues).all
    end

    respond_to do |format|
      format.html
      format.json { render :json => @hops.to_json(:include => :venues) }
    end
  end
  
  def create
    @hop = Hop.new(params[:hop])
    if @hop.save
      redirect_to @hop
    else
      redirect_to hops_path, :alert => @hop.errors.full_messages.join("<br/>")
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
