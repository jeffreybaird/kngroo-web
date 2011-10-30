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
  
end
