require 'test_helper'

class Hops::VenuesControllerTest < ActionController::TestCase

  context "when not signed in" do
    setup do
      @user = Factory(:user)
      @hop = Factory(:hop)
      @venue = Factory(:venue)
      @hop.venues << @venue
      @user.hops << @hop
      sign_out
    end
    
    context "on get index" do
      setup { get :index, :hop_id => @hop.id }
      should ("redirect to sign in"){redirect_to sign_in_path}
    end
    
    context "on get show" do
      setup { get :show, :hop_id => @hop.id, :id => @venue.id }
      should ("redirect to sign in"){redirect_to sign_in_path}
    end
  end
  
  context "when signed in" do
    setup do
      @user = Factory(:user)
      @hop = Factory(:hop)
      @venue = Factory(:venue)
      @hop.venues << @venue
      @user.hops << @hop
      @assignment = @user.assignments.first
      sign_in_as @user
    end
    
    context "on get index" do
      setup { get :index, :hop_id => @hop.id }
      should respond_with :success
      should assign_to :hop
      should assign_to :venues
    end
    
    context "on get show" do
      setup { get :show, :hop_id => @hop.id, :id => @venue.id }
      should respond_with :success
      should assign_to :hop
      should assign_to :venue
    end
  end
  
end
