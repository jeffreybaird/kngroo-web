class SessionsController < Clearance::SessionsController
  
  def url_after_create
    if current_user.has_role?('admin')
      hops_path
    else
      user_hops_path
    end
  end
  
  def url_after_destroy
    root_path
  end
  
  def hash_after_create
    { :session => { :user_id => current_user.id, :api_token => current_user.api_token } }
  end
  
end
