class Hops::VenuesController < ApplicationController

  before_filter :authorize
  before_filter :assign_hop
  before_filter :assign_venue, :only => [ :show, :checkin ]
  
  def index
    @venues = @hop.venues
    respond_to do |format|
      format.html
      format.json { render :json => @venues }
    end
  end
  
  def show
    respond_to do |format|
      format.html
      format.json { render json: @venue }
    end
  end
  
  def checkin
    @checkin = Checkin.new(:assignment_id => Assignment.find_by_hop_id_and_user_id(@hop.id, current_user.id).id, :venue_id => @venue.id)
    respond_to do |format|
      if @checkin.save
        format.html { redirect_to hop_venue_path(@hop,@venue) }
        format.json { render :json => @checkin.to_json(:methods => :trophy_awarded) }
      else
        format.html { redirect_to hop_venue_path(@hop, @venue), :alert => @checkin.errors.full_messages.join("<br/>") }
        format.json { render :json => { :errors => @checkin.errors.full_messages } }
      end
    end
  end
  
  def assign_hop
    @hop = Hop.find(params[:hop_id]) if params[:hop_id]
    deny_access unless @hop.users.include?(current_user)
  end
  
  def assign_venue
    @venue = Venue.find(params[:id])
  end
  
end
