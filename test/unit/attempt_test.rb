require 'test_helper'

class AttemptTest < ActiveSupport::TestCase

  should belong_to :user
  should belong_to :trivia

  should validate_presence_of :user_id
  should validate_presence_of :trivia_id
  
end
