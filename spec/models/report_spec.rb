# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Report, type: :model do
  describe '#editable?' do
    let!(:report) { FactoryBot.build_stubbed(:report) }

    context '所有しているユーザーを引数に与えると' do
      it 'trueを答える' do
        expect(report.editable?(report.user)).to be_truthy
      end
    end

    context '所有していないユーザーを引数に与えると' do
      user_not_onwer = FactoryBot.build(:user)
      it 'falseを答える' do
        expect(report.editable?(user_not_onwer)).to be_falsey
      end
    end
  end

  describe '#created_on' do
    it '日報の作成時刻を答える' do
      date = DateTime.new(2023, 6, 23, 12, 34, 56)
      report = FactoryBot.build(:report, created_at: date)
      expect(report.created_on).to eq date.to_date
    end
  end

  describe '#save_mentions' do
    it '日報保存後、日報本文にその他の日報のURLがある場合、対象の日報を言及先として関連付ける' do
      mentioned_report = FactoryBot.create(:report)
      mentioning_report = FactoryBot.build(:report, content: "http://localhost:3000/reports/#{mentioned_report.id}")

      expect { mentioning_report.save }.to change { mentioning_report.mentioning_report_ids }.from([]).to([mentioned_report.id])
    end
  end
end
