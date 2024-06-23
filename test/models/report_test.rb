# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'editable or not editable ' do
    assert reports(:one).editable?(users(:david))
    assert_not reports(:one).editable?(users(:alice))
  end

  test 'the date of created_at' do
    report = reports(:one)
    date = report.created_at
    assert_equal date.to_date, report.created_on
  end
end
