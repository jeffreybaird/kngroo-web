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
  
end
