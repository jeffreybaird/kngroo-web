class Hops::VenuesController < ApplicationController

  layout nil, :only => :search
  
  before_filter :authorize
  before_filter :assign_hop
  before_filter :assign_venue, :only => [ :show, :update, :destroy ]
  
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
  
  # def checkin
  #   @checkin = Checkin.new(:assignment_id => Assignment.find_by_hop_id_and_user_id(@hop.id, current_user.id).id, :venue_id => @venue.id)
  #   respond_to do |format|
  #     if @checkin.save
  #       format.html { redirect_to hop_venue_path(@hop,@venue) }
  #       format.json { render :json => @checkin.to_json(:methods => :trophy_awarded) }
  #     else
  #       format.html { redirect_to hop_venue_path(@hop, @venue), :alert => @checkin.errors.full_messages.join("<br/>") }
  #       format.json { render :json => { :errors => @checkin.errors.full_messages } }
  #     end
  #   end
  # end
  
  def update
    if @venue.update_attributes(params[:venue])
      redirect_to [@hop,@venue]
    else
      redirect_to [@hop,@venue], :alert => @venue.errors.full_messages.join("<br/>")
    end
  end
  
  def search
    rsp = Foursquare::Venue.search(ll:"#{params[:lat]},#{params[:lng]}",radius:25000,intent:"browse",query:params[:query].gsub(/ /,'+'))
    @venues = []
    groups = rsp['response']['groups']
    if groups && !groups.empty?
      items = groups.first['items']
      for item in items
        venue = Venue.find_or_create_by_name(item['name'])
        venue.lat = item['lat']
        venue.lng = item['lng']
        venue.save
        @venues << venue
      end
    end
    respond_to do |format|
      format.js
    end
  end
  
  def assign_hop
    @hop = Hop.find(params[:hop_id]) if params[:hop_id]
    # deny_access unless @hop.users.include?(current_user)
  end
  
  def assign_venue
    @venue = Venue.find(params[:id])
  end
  
end
