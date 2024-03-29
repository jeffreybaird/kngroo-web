class UsersController < Clearance::UsersController

  before_filter :authorize, :only => [ :show, :update, :destroy ]
  
  def show
    @user = User.includes(:trophies => :hop).where(:id => current_user.id).first
    respond_to do |format|
      format.html
      format.json { render :json => @user.to_json(:include => { :trophies => { :include => :hop } }) }
    end
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
