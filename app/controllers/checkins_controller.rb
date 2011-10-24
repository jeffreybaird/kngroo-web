class CheckinsController < ApplicationController

  before_filter :authorize
  before_filter :assign_assignment
  before_filter :assign_venue

  def create
    @checkin = Checkin.new(:assignment_id => @assignment.id, :venue_id => @venue.id)
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
  
  def assign_assignment
    @assignment = Assignment.find(params[:assignment_id]) if params[:assignment_id]
    deny_access unless @assignment.user==current_user
  end
  
  def assign_venue
    @venue = Venue.find(params[:venue_id])
  end
  
end
