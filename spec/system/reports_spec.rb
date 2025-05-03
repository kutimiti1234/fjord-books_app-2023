# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reports', type: :system do
  before(:each) do
    @user = FactoryBot.create(:user)
    sign_in @user
  end

  scenario '日報の一覧を表示する' do
    visit reports_path
    expect(page).to have_selector 'h1', text: '日報の一覧'
  end

  scenario '日報の新規作成' do
    visit reports_path
    click_link '日報の新規作成'
    fill_in 'タイトル', with: '活動報告1'
    fill_in '内容', with: 'とても疲れた'
    click_button '登録する'

    expect(page).to have_text '日報が作成されました'
    expect(page).to have_text '活動報告1'
    expect(page).to have_text 'とても疲れた'
  end

  scenario '日報の新規作成' do
    report = FactoryBot.create(:report, user: @user)
    visit report_path(report)
    click_on 'この日報を編集'
    fill_in 'タイトル', with: '活動報告1'
    fill_in '内容', with: 'とても疲れた'
    click_button '更新する'

    expect(page).to have_text '日報が更新されました'
    expect(page).to have_text '活動報告1'
    expect(page).to have_text 'とても疲れた'
  end

  scenario '日報の削除' do
    report = FactoryBot.create(:report, user: @user)
    visit report_path(report)
    click_on 'この日報を削除'

    expect(page).to have_text '日報が削除されました'
  end
end
