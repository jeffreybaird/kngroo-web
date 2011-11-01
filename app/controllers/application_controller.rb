class ApplicationController < ActionController::Base
  include Clearance::Authentication
  protect_from_forgery

  rescue_from(ActiveRecord::RecordNotFound) do |e| 
    respond_to do |format| 
      format.html { render :file => 'public/404.html' } 
      format.json { render :json => { :errors => [ "Record does not exist"] }, :status => :not_found }
    end
  end
  rescue_from(ActionController::RoutingError) do |e|
    respond_to do |format| 
      format.html { render :file => 'public/404.html' } 
      format.json { render :json => { :errors => [ "Record does not exist"] }, :status => :not_found }
    end
  end
  
  def deny_access
    respond_to do |format|
      format.html { redirect_to sign_in_path }
      format.json { render :json => { :errors => [ "You must be signed in" ] }, :status => :unauthorized }
    end
  end
  
end
