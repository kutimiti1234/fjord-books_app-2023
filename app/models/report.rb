# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :report_mentions, dependent: :destroy
  has_many :mentioning_reports, through: :report_mentions, source: :mentioned_report
  has_many :mentioned_reports, through: :report_mentions, source: :report

  validates :title, presence: true
  validates :content, presence: true

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  def mentioned_reports
    ReportMention.where(mentioned_reports: id)
  end

  def mentioned_reports_ids
    mentioned_reports.map(&:id)
  end
end
