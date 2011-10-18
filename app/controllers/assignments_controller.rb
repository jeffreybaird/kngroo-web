class AssignmentsController < ApplicationController

  before_filter :authorize
  
  def create
    @assignment = Assignment.new(params[:assignment])
    @assignment.user_id = current_user.id
    @assignment.save
    redirect_to user_hops_path
  end
  
  def destroy
    @assignment = Assignment.find(params[:id])
    @assignment.destroy
    redirect_to user_hops_path
  end
  
end
