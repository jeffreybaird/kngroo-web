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
    
    context "on get checkin" do
      setup { get :checkin, :hop_id => @hop.id, :id => @venue.id }
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

    context "for a hop with three venues and two checkins" do
      setup do
        @venue2 = Factory(:venue)
        @venue3 = Factory(:venue)
        @hop.venues << [@venue2, @venue3]
        @checkin1 = Checkin.create(:hop_id => @hop.id, :venue_id => @venue2, :user_id => @user.id)
        @checkin2 = Checkin.create(:hop_id => @hop.id, :venue_id => @venue2, :user_id => @user.id)
      end
      
      context "on get checkin" do
        setup do
          # @trophy_count = Trophy.where(:hop_id => @hop.id, :user_id => @user.id).count
          @trophy_count = Trophy.count
          get :checkin, :hop_id => @hop.id, :id => @venue.id
        end
        should ("redirect to hop venue"){redirect_to hop_venue_path(@hop,@venue)}
        should ("have a new trophy associated with this hop"){assert_equal(@trophy_count+1,Trophy.count)}
      end
    end
  end
  
end
