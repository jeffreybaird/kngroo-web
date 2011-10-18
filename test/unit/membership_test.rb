require 'test_helper'

class MembershipTest < ActiveSupport::TestCase

  should belong_to :hop
  should belong_to :venue
  
  should validate_presence_of :hop_id
  should validate_presence_of :venue_id

end
