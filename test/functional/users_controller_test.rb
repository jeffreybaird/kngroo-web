require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  context "when not signed in" do
    setup do
      @user = Factory(:user)
      sign_out
    end
    
    context "on get new" do
      setup { get :new }
      should respond_with :success
      should assign_to :user
    end
    
    context "on post create" do
      setup do
        @user_count = User.count
        post :create, :user => Factory.attributes_for(:user)
      end
      # should ("increase number of users by 1"){assert_equal(@user_count+1,User.count)}
      should ("redirect to root"){redirect_to root_path}
    end
  end
  
  context "when signed in" do
    setup do
      @user = Factory(:user)
      sign_in_as @user
    end

    context "on get show" do
      setup { get :show }
      should respond_with :success
      should assign_to :user
    end
    
    context "on put update" do
      setup { put :update, :user => Factory.attributes_for(:user) }
      should ("redirect to user"){redirect_to user_path}
    end
    
    context "on delete destroy" do
      setup do
        @user_count = User.count
        delete :destroy
      end
      # should ("decrease number of users by 1"){assert_equal(@user_count-1,User.count)}
      should ("redirect to root"){redirect_to root_path}
    end
  end
  
end
