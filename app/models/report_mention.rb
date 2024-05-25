# frozen_string_literal: true

class ReportMention < ApplicationRecord
  belongs_to :report
  belongs_to :mentioned_report, class_name: 'Report'

  validates :report_id, uniqueness: { scope: :mentioned_report_id }
end
