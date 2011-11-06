require 'test_helper'

class AttemptsControllerTest < ActionController::TestCase

  context "when not signed in" do
    setup do
      @user = Factory(:user)
      @hop = Factory(:hop)
      @venue = Factory(:venue)
      @membership = Factory(:membership, :hop => @hop, :venue => @venue)
      @trivia = Factory(:trivia, :hop => @hop, :venue => @venue, :question => "How many stars in the sky?", :answer => 42, :numeric_answer => true)
      @assignment = Factory(:assignment, :user => @user, :hop => @hop)
      sign_out
    end
      
    context "on post create as json" do
      setup { post :create, :format => "json", :assignment_id => @assignment.id, :venue_id => @venue.id }
      should respond_with :unauthorized
    end
  end
  
  context "when signed in" do
    setup do
      @user = Factory(:user)
      @hop = Factory(:hop)
      @venue = Factory(:venue)
      @membership = Factory(:membership, :hop => @hop, :venue => @venue)
      @trivia = Factory(:trivia, :hop => @hop, :venue => @venue, :question => "How many stars in the sky?", :answer => 42, :numeric_answer => true)
      @assignment = Factory(:assignment, :user => @user, :hop => @hop)
      sign_in_as @user
    end

    context "on post create as json" do
      setup { post :create, :format => "json", :assignment_id => @assignment.id, :venue_id => @venue.id, :attempt => Factory.attributes_for(:attempt, :trivia_id => @trivia.id) }
      should respond_with :success
    end
  end

end
