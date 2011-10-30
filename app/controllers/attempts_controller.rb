class AttemptsController < ApplicationController

  before_filter :authorize
  
  def create
    @attempt = Attempt.new(params[:attempt])
    @attempt.user_id = current_user.id
    respond_to do |format|
      if @attempt.save
        format.json { render :json => @attempt }
      else
        format.json { render :json => { :errors => @attempt.errors.full_messages }, :status => :unprocessable_entity }
      end
    end
  end
  
end
