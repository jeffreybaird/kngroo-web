require 'test_helper'

class CheckinsControllerTest < ActionController::TestCase

  context "when not signed in" do
    setup do
      @user = Factory(:user)
      sign_out
    end
    
    context "for a hop with two venues and one checkin" do
      setup do
        @hop = Factory(:hop)
        @venue1 = Factory(:venue)
        @venue2 = Factory(:venue)
        @hop.venues << [@venue1, @venue2]
        @assignment = Factory(:assignment, :user => @user, :hop => @hop)
        @checkin1 = Checkin.create(:assignment_id => @assignment.id, :venue_id => @venue1.id)
      end
      
      context "on post create with already checked-in venue as json" do
        setup do
          post :create, :format => "json", :assignment_id => @assignment.id, :venue_id => @venue1.id
        end
        should respond_with :unauthorized
        # should ("redirect to sign in"){redirect_to sign_in_path}
      end
      
      context "on post create as json" do
        setup do
          @trophy_count = Trophy.count
          post :create, :format => "json", :assignment_id => @assignment.id, :venue_id => @venue2.id
        end
        should respond_with :unauthorized
        # should ("redirect to sign in"){redirect_to sign_in_path}
      end
    end
  end
  
  context "when signed in" do
    setup do
      @user = Factory(:user)
      sign_in_as @user
    end

    context "for a hop with two venues and one checkin" do
      setup do
        @hop = Factory(:hop)
        @venue1 = Factory(:venue)
        @venue2 = Factory(:venue)
        @hop.venues << [@venue1, @venue2]
        @assignment = Factory(:assignment, :user => @user, :hop => @hop)
        @checkin1 = Checkin.create(:assignment_id => @assignment.id, :venue_id => @venue1)
      end
      
      context "on post create with already checked-in venue as json" do
        setup do
          post :create, :format => "json", :assignment_id => @assignment.id, :venue_id => @venue1.id
        end
        # should ("redirect to user hop venue"){redirect_to user_hop_venue_path(@hop,@venue1)}
        # should set_the_flash.to(:alert => /already/)
        should respond_with :unprocessable_entity
      end
      
      context "on post create as json" do
        setup do
          # @trophy_count = Trophy.count
          post :create, :format => "json", :assignment_id => @assignment.id, :venue_id => @venue2.id
        end
        # should ("redirect to user hop venue"){redirect_to user_hop_venue_path(@hop,@venue2)}
        should respond_with :success
        # should ("have a new trophy associated with this hop"){assert_equal(@trophy_count+1,Trophy.count)}
      end
    end
  end
  
end
