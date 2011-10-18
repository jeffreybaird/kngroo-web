require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  should have_many :hops
  should validate_presence_of :title
  
end
