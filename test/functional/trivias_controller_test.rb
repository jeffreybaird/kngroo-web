require 'test_helper'

class TriviasControllerTest < ActionController::TestCase

  context "when not signed in" do
    setup do
      @user = Factory(:user)
      (1..3).each do |n|
        hop = Factory(:hop)
        venue = Factory(:venue)
        membership = Factory(:membership, :hop => hop, :venue => venue)
        trivia = Factory(:trivia, :hop => hop, :venue => venue, :question => "How many ball bearings in a jar?", :answer => n, :numeric_answer => true)
      end
      @hop = Factory(:hop)
      @venue = Factory(:venue)
      @membership = Factory(:membership, :hop => @hop, :venue => @venue)
      @trivia = Factory(:trivia, :hop => @hop, :venue => @venue, :question => "How many stars in the sky?", :answer => 42, :numeric_answer => true)
      @assignment = Factory(:assignment, :user => @user, :hop => @hop)
      sign_out
    end
    
    context "on get index as json" do
      setup { get :index, :assignment_id => @assignment.id, :venue_id => @venue.id, :format => 'json' }
      should respond_with :unauthorized
    end
    
    context "on post create" do
      setup { post :create, :hop_id => @hop.id, :venue_id => @venue.id, :trivia => Factory.attributes_for(:trivia, :hop_id => @hop.id, :venue_id => @venue.id) }
      should ("redirect to sign in"){redirect_to sign_in_path}
    end
    
    context "on put update" do
      setup { put :update, :hop_id => @hop.id, :venue_id => @venue.id, :id => @trivia.id, :trivia => Factory.attributes_for(:trivia, :question => @trivia.question, :answer => @trivia.answer) }
      should ("redirect to sign in"){redirect_to sign_in_path}
    end
    
    context "on delete destroy" do
      setup { delete :destroy, :hop_id => @hop.id, :venue_id => @venue.id, :id => @trivia.id }
      should ("redirect to sign in"){redirect_to sign_in_path}
    end
  end

  context "when signed in as user" do
    setup do
      @user = Factory(:user)
      (1..3).each do |n|
        hop = Factory(:hop)
        venue = Factory(:venue)
        membership = Factory(:membership, :hop => hop, :venue => venue)
        trivia = Factory(:trivia, :hop => hop, :venue => venue, :question => "How many ball bearings in a jar?", :answer => n, :numeric_answer => true)
      end
      @hop = Factory(:hop)
      @venue = Factory(:venue)
      @membership = Factory(:membership, :hop => @hop, :venue => @venue)
      @trivia = Factory(:trivia, :hop => @hop, :venue => @venue, :question => "How many stars in the sky?", :answer => 42, :numeric_answer => true)
      @assignment = Factory(:assignment, :user => @user, :hop => @hop)
      sign_in_as @user
    end
    
    context "on get index as json" do
      setup { get :index, :assignment_id => @assignment.id, :venue_id => @venue.id, :format => 'json' }
      should respond_with :success
    end
    
    context "on post create" do
      setup { post :create, :hop_id => @hop.id, :venue_id => @venue.id, :trivia => Factory.attributes_for(:trivia, :hop_id => @hop.id, :venue_id => @venue.id) }
      should ("redirect to sign in"){redirect_to sign_in_path}
    end
    
    context "on put update" do
      setup { put :update, :hop_id => @hop.id, :venue_id => @venue.id, :id => @trivia.id, :trivia => Factory.attributes_for(:trivia, :question => @trivia.question, :answer => @trivia.answer) }
      should ("redirect to sign in"){redirect_to sign_in_path}
    end
    
    context "on delete destroy" do
      setup { delete :destroy, :hop_id => @hop.id, :venue_id => @venue.id, :id => @trivia.id }
      should ("redirect to sign in"){redirect_to sign_in_path}
    end
  end

  context "when signed in as admin" do
    setup do
      @user = Factory(:user, :role_name => 'admin')
      @hop = Factory(:hop)
      @venue = Factory(:venue)
      @membership = Factory(:membership, :hop => @hop, :venue => @venue)
      @trivia = Factory(:trivia, :hop => @hop, :venue => @venue, :question => "How many stars in the sky?", :answer => 42, :numeric_answer => true)
      @assignment = Factory(:assignment, :user => @user, :hop => @hop)
      sign_in_as @user
    end
    
    context "on post create" do
      setup { post :create, :hop_id => @hop.id, :venue_id => @venue.id, :trivia => Factory.attributes_for(:trivia, :hop_id => @hop.id, :venue_id => @venue.id) }
      should ("redirect to hop venue"){redirect_to [@hop,@venue]}
    end
    
    context "on put update" do
      setup { put :update, :hop_id => @hop.id, :venue_id => @venue.id, :id => @trivia.id, :trivia => Factory.attributes_for(:trivia, :question => @trivia.question, :answer => @trivia.answer) }
      should ("redirect to hop venue"){redirect_to [@hop,@venue]}
    end
    
    context "on delete destroy" do
      setup { delete :destroy, :hop_id => @hop.id, :venue_id => @venue.id, :id => @trivia.id }
      should ("redirect to hop venue"){redirect_to [@hop,@venue]}
    end
  end

end
