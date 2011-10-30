class TriviasController < ApplicationController

  before_filter :authorize
  before_filter :assign_hop
  before_filter :assign_venue
  
  def create
    @trivia = Trivia.new(params[:trivia])
    @trivia.hop_id = @hop.id
    @trivia.venue_id = @venue.id
    if @trivia.save
      redirect_to [@hop,@venue]
    else
      redirect_to [@hop,@venue], :alert => @trivia.errors.full_messages.join("<br/>")
    end
  end
  
  def show
    @trivia = Trivia.where(:hop_id => @hop.id, :venue_id => @venue.id).order('random()').limit(1).first
    respond_to do |format|
      format.json { render :json => @trivia.to_json(:methods => :wrong_answers) }
    end
  end
  
  def update
    @trivia = Trivia.find(params[:id])
    if @trivia.update_attributes(params[:trivia])
      redirect_to [@hop,@venue]
    else
      redirect_to [@hop,@venue], :alert => @trivia.errors.full_messages.join("<br/>")
    end
  end
  
  def destroy
    @trivia = Trivia.find(params[:id])
    @trivia.destroy
    redirect_to [@hop,@venue]
  end

  def assign_hop
    @hop = Hop.find(params[:hop_id]) if params[:hop_id]
    # deny_access unless @hop.users.include?(current_user)
  end
  
  def assign_venue
    @venue = Venue.find(params[:venue_id]) if params[:venue_id]
  end
    
end
