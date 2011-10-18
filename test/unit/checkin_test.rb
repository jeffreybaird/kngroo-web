require 'test_helper'

class CheckinTest < ActiveSupport::TestCase

  should belong_to :user
  should belong_to :hop
  should belong_to :venue

  should validate_presence_of :user_id
  should validate_presence_of :hop_id
  should validate_presence_of :venue_id

end
