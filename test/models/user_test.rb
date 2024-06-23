# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'show name if name exsit or show email if name not exist ' do
    assert_equal 'david', users(:david).name_or_email
    assert_equal 'example2@gmail.com', users(:alice).name_or_email
  end
end
