# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :mentioning_relations, class_name: 'ReportMention', dependent: :destroy, foreign_key: :mentioning_id, inverse_of: :mentioning
  has_many :mentioning_reports, through: :mentioning_relations, source: :mentioned
  has_many :mentioned_relations, class_name: 'ReportMention', dependent: :destroy, foreign_key: :mentioned_id, inverse_of: :mentioned
  has_many :mentioned_reports, through: :mentioned_relations, source: :mentioning

  validates :title, presence: true
  validates :content, presence: true

  before_save :update_report_mentions

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  def mentioned_reports
    ReportMention.where(mentioned_report: id).map { |mention| Report.find(mention.report_id) }
  end

  def mentioned_reports_ids
    mentioned_reports.map(&:report_id)
  end

  def parse_url_in_content(content)
    r = %r{http://localhost:3000/reports/(\d+)}
    content.scan(r).flatten.map(&:to_i)
  end

  def update_report_mentions
    current_urls = parse_url_in_content(content)
    existing_urls = mentioning_report_ids

    (current_urls - existing_urls).each do |mentioning_report_id|
      mentioning_report = Report.find_by(id: mentioning_report_id)
      mentioning_reports << mentioning_report if mentioning_report
    end

    (existing_urls - current_urls).each do |mentioning_report_id|
      mentioning_report = Report.find_by(id: mentioning_report_id)
      mentioning_reports.delete(mentioning_report) if mentioning_report
    end
  end
end
