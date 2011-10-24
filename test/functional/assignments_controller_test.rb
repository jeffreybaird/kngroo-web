require 'test_helper'

class AssignmentsControllerTest < ActionController::TestCase

  context "when not signed in" do
    setup do
      @user = Factory(:user)
      @hop = Factory(:hop)
      sign_out
    end
    
    context "on post create" do
      setup { post :create, :assignment => { :hop_id => @hop.id } }
      should ("redirect to sign in"){redirect_to sign_in_path}
    end
    
    context "on delete destroy" do
      setup do
        @assignment = Factory(:assignment, :user => @user, :hop => @hop)
        delete :destroy, :id => @assignment.id
      end
      should ("redirect to sign in"){redirect_to sign_in_path}
    end
  end
  
  context "when signed in" do
    setup do
      @user = Factory(:user)
      @hop = Factory(:hop)
      sign_in_as @user
    end
    
    context "on post create" do
      setup { post :create, :assignment => { :hop_id => @hop.id } }
      should ("redirect to user hops"){redirect_to user_hops_path}
    end
    
    context "on delete destroy" do
      setup do
        @assignment = Factory(:assignment, :user => @user, :hop => @hop)
        delete :destroy, :id => @assignment.id
      end
      should ("redirect to user hops"){redirect_to user_hops_path}
    end
  end

end
