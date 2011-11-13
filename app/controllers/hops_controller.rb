class HopsController < ApplicationController

  before_filter :authorize, :except => :index
  
  def index
    if signed_in? && current_user.has_role?('admin')
      @hops = Hop.includes(:venues).all
    elsif signed_in? && current_user.has_role?('user')
      @hops = Hop.published.includes(:venues).all - Assignment.active.where(:user_id => current_user.id).map(&:hop)
    else
      @hops = Hop.published.includes(:venues).all
    end

    respond_to do |format|
      format.html
      format.json { render :json => @hops.to_json(:include => :venues, :methods => [ :stamp_url, :image_url ]) }
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
  
  def update
    @hop = Hop.find(params[:id])
    if @hop.update_attributes(params[:hop])
      redirect_to @hop
    else
      redirect_to @hop, :alert => @hop.errors.full_messages.join("<br/>")
    end
  end
  
  def destroy
    @hop = Hop.find(params[:id])
    @hop.destroy
    redirect_to hops_path
  end
  
  def publish
    @hop = Hop.find(params[:id])
    deny_access unless current_user.has_role?('admin')
    @hop.published_at = Time.now
    @hop.save
    redirect_to @hop
  end
  
end
