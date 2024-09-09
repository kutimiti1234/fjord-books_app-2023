# frozen_string_literal: true

class ReportMention < ApplicationRecord
  belongs_to :mentioning, class_name: 'Report', inverse_of: :mentioning_relations
  belongs_to :mentioned, class_name: 'Report', inverse_of: :mentioned_relations

  validates :mentioning_id, uniqueness: { scope: :mentioned_id }
end
