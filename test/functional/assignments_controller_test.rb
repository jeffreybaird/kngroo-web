require 'test_helper'

class AssignmentsControllerTest < ActionController::TestCase

  context "when not signed in" do
    setup do
      @user = Factory(:user)
      @hop = Factory(:hop)
      @hop.users << @user
      sign_out
    end
    
    context "on post create" do
      setup { post :create, :assignment => { :hop_id => @hop.id } }
      should ("redirect to sign in"){redirect_to sign_in_path}
    end
    
    context "on delete destroy" do
      setup { delete :destroy, :id => @hop.assignments.first.id }
      should ("redirect to sign in"){redirect_to sign_in_path}
    end
  end
  
  context "when signed in" do
    setup do
      @user = Factory(:user)
      @hop = Factory(:hop)
      @hop.users << @user
      sign_in_as @user
    end
    
    context "on post create" do
      setup { post :create, :assignment => { :hop_id => @hop.id } }
      should ("redirect to user hops"){redirect_to user_hops_path}
    end
    
    context "on delete destroy" do
      setup { delete :destroy, :id => @hop.assignments.first.id }
      should ("redirect to user hops"){redirect_to user_hops_path}
    end
  end

end
