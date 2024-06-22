# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'show name if name exsit ' do
    assert_equal 'david', users(:david).name_or_email
  end

  test 'show email if name not exsit ' do
    assert_equal 'example2@gmail.com', users(:alice).name_or_email
  end
end
