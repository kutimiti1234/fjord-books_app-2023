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

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  def parse_url_in_content
    r = %r{http://localhost:3000/reports/(\d+)}
    content.scan(r).flatten.map(&:to_i).uniq
  end

  def update_mentions
    Report.transaction do
      current_ids = parse_url_in_content
      existing_ids = mentioning_report_ids

      reports = Report.all.index_by(&:id)
      adding_report_ids = current_ids - existing_ids
      deleting_report_ids = existing_ids - current_ids

      adding_reports = adding_report_ids.map do |mentioning_report_id|
        reports[mentioning_report_id]
      end.compact
      mentioning_reports.concat adding_reports

      deleting_reports = deleting_report_ids.map do |mentioning_report_id|
        reports[mentioning_report_id]
      end.compact
      mentioning_reports.delete(deleting_reports)
    end
  end
end
