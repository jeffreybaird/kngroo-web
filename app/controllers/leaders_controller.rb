class LeadersController < ApplicationController

  before_filter :authorize
  
  def index
    @users = User.order('points desc').limit(10)
    respond_to do |format|
      format.html
      format.json { render :json => @users.to_json(:only => [ :first_name, :last_name, :points ]) }
    end
  end

end
