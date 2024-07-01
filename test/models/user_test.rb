# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test '#name_or_email' do
    user_without_name = users(:alice)
    assert_equal 'example2@example.com', user_without_name.name_or_email

    user = users(:bob)
    assert_equal 'bob', user.name_or_email
  end
end
