class TriviasController < ApplicationController

  before_filter :authorize
  before_filter :assign_hop, :only => [ :create, :update, :destroy ]
  before_filter :assign_venue
  before_filter :assign_assignment, :only => [ :index ]
  
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
  
  def index
    trivia = Trivia.where(:hop_id => @assignment.hop_id, :venue_id => @venue.id).order('random()').limit(1).first
    @trivias = [trivia] + trivia.wrong_answers
    respond_to do |format|
      format.json { render :json => @trivias }
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
  
  def assign_assignment
    @assignment = Assignment.find(params[:assignment_id]) if params[:assignment_id]
    deny_access unless @assignment.user==current_user
  end
  
  def assign_venue
    @venue = Venue.find(params[:venue_id]) if params[:venue_id]
  end
    
end
