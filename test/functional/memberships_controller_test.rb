require 'test_helper'

class MembershipsControllerTest < ActionController::TestCase

  context "when not signed in" do
    setup do
      @user = Factory(:user)
      @hop = Factory(:hop)
      @venue = Factory(:venue)
      sign_out
    end
    
    context "on post create" do
      setup { post :create, :membership => Factory.attributes_for(:membership, :hop_id => @hop.id, :venue_id => @venue.id) }
      should ("redirect to sign in"){redirect_to sign_in_path}
    end
    
    context "on delete destroy" do
      setup do
        @membership = Factory(:membership, :hop => @hop, :venue => @venue)
        delete :destroy, :id => @membership.id
      end
      should ("redirect to sign in"){redirect_to sign_in_path}
    end
  end

  context "when signed in" do
    setup do
      @user = Factory(:user)
      @hop = Factory(:hop)
      @venue = Factory(:venue)
      sign_in_as @user
    end
    
    context "on post create" do
      setup { post :create, :membership => Factory.attributes_for(:membership, :hop_id => @hop.id, :venue_id => @venue.id) }
      should ("redirect to hop"){redirect_to @hop}
    end
    
    context "on delete destroy" do
      setup do
        @membership = Factory(:membership, :hop => @hop, :venue => @venue)
        delete :destroy, :id => @membership.id
      end
      should ("redirect to hop"){redirect_to @hop}
    end
  end

end
