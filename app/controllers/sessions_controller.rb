class SessionsController < Clearance::SessionsController
  
  def url_after_create
    user_hops_path
  end
  
  def url_after_destroy
    root_path
  end
  
end
