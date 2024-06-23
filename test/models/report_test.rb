# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'editable or not editable ' do
    report = Report.new(user_id: 1)
    assert report.editable?(users(:one))
    assert_not reports(:one).editable?(users(:two))
  end

  test 'the date of created_at' do
    date = DateTime.new(2023, 6, 23, 12, 34, 56)
    report = Report.new(title: 'example', created_at: date)
    assert_equal date.to_date, report.created_on
  end

  test 'report_mentioning' do
    report = Report.new(title: 'example', content: 'http://localhost:3000/reports/2', user_id: 1)
    assert_not_equal [2], report.mentioning_report_ids
    report.save
    assert_equal [2], report.mentioning_report_ids
  end
end
