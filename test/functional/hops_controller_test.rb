require 'test_helper'

class HopsControllerTest < ActionController::TestCase

  context "when not signed in" do
    setup do
      @user = Factory(:user)
      @hop = Factory(:hop)
      sign_out
    end
    
    context "on get index" do
      setup { get :index }
      should ("redirect to sign in"){redirect_to sign_in_path}
    end
    
    context "on get show" do
      setup { get :show, :id => @hop.id }
      should ("redirect to sign in"){redirect_to sign_in_path}
    end
  end
  
  context "when signed in" do
    setup do
      @user = Factory(:user)
      @hop = Factory(:hop)
      sign_in_as @user
    end
    
    context "on get index" do
      setup { get :index }
      should respond_with :success
      should assign_to :hops
    end
    
    context "on get show" do
      setup { get :show, :id => @hop.id }
      should respond_with :success
      should assign_to :hop
    end
  end
  
end
