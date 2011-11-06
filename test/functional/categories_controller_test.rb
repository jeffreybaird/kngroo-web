require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase

  context "when not signed in" do
    setup do
      @user = Factory(:user)
      sign_out
    end
    
    context "on get index as json" do
      setup { get :index, :format => 'json' }
      should respond_with :unauthorized
    end
  end

  context "when signed in" do
    setup do
      @user = Factory(:user)
      sign_in_as @user
    end
    
    context "on get index as json" do
      setup { get :index, :format => 'json' }
      should respond_with :success
    end
  end

end
