# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'show name if name exsit or show email if name not exist ' do
    user = User.new(email: 'example@example.com', name: 'david')
    user_without_name = User.new(email: 'example@example.com')
    assert_equal 'david', user.name_or_email
    assert_equal 'example@example.com', user_without_name.name_or_email
  end
end
