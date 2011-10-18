require 'test_helper'

class ConfirmationTest < ActiveSupport::TestCase

  should belong_to :trivia
  should belong_to :user
  
  should validate_presence_of :trivia_id
  should validate_presence_of :user_id
  
end
