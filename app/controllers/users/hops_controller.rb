class Users::HopsController < ApplicationController

  before_filter :authorize
  
  def index
    @hops = current_user.hops
    respond_to do |format|
      format.html
      format.json { render :json => @hops }
    end
  end
  
  def show
    @hop = Hop.includes(:venues, :checkins).joins(:assignments).where(['assignments.user_id = ?',current_user.id]).find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @hop.to_json(:include => [ :venues, :checkins ]) }
    end
  end
  
end
