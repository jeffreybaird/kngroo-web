class AssignmentsController < ApplicationController

  before_filter :authorize
  
  def index
    @assignments = Assignment.includes(:hop => :venues, :checkins => {}).where(:user_id => current_user.id)
    
    respond_to do |format|
      format.html
      format.json { render :json => @assignments.to_json(:include => { :hop => { :include => :venues, :methods => [ :stamp_url, :image_url ] }, :checkins => {} }) }
    end
  end
  
  def create
    @assignment = Assignment.new(params[:assignment])
    @assignment.user_id = current_user.id
    @assignment.complete = false
    
    respond_to do |format|
      if @assignment.save
        format.html { redirect_to user_hops_path }
        format.json { render :json => @assignment.to_json(:include => { :hop => { :include => :venues }, :checkins => {} }) }
      else
        format.html { redirect_to user_hops_path, :alert => @assignment.errors.full_messages.join("<br/>") }
        format.json { render :json => { :errors => @assignment.errors.full_messages }, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @assignment = Assignment.find(params[:id])
    @assignment.destroy

    respond_to do |format|
      format.html { redirect_to user_hops_path }
      format.json { head :ok }
    end
  end
  
end
