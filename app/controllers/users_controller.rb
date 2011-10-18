class UsersController < Clearance::UsersController
  
  def show
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to @user
    else
      redirect_to @user, :alert => @user.errors.full_messages.join("<br/>")
    end
  end

  def destroy
    @user = current_user
    current_user = nil
    @user.destroy
    redirect_to root_path
  end
  
end
