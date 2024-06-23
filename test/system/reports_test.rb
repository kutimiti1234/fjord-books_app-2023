# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @report = reports(:one)

    visit root_url
    fill_in 'Eメール', with: 'example@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    assert_text 'ログインしました'
  end

  test 'visiting the index' do
    visit reports_url
    assert_selector 'h1', text: '日報の一覧'
  end

  test 'should create report' do
    visit reports_url
    click_link '日報の新規作成'

    fill_in '内容', with: 'とても疲れた'
    fill_in 'タイトル', with: '活動報告1'
    click_button '登録する'

    assert_text 'とても疲れた'
    assert_text '活動報告1'
    assert_text '日報が作成されました。'
  end

  test 'should update Report' do
    visit report_url(@report)
    click_link 'この日報を編集', match: :first

    fill_in '内容', with: 'すごく頑張った。'
    fill_in 'タイトル', with: '日報#2'
    click_button '更新する'

    assert_text 'すごく頑張った。'
    assert_text '日報#2'

    assert_text '日報が更新されました。'
  end

  test 'should destroy Report' do
    visit report_url(@report)
    click_on 'この日報を削除', match: :first

    assert_text '日報が削除されました。'
  end

  test 'should show error when content is not provided' do
    visit reports_url
    click_link '日報の新規作成'

    fill_in '内容', with: ''
    fill_in 'タイトル', with: '活動日報#34'
    click_button '登録する'
    assert_selector 'li', exact_text: '内容を入力してください'
  end

  test 'should show error when title is not provided' do
    visit reports_url
    click_link '日報の新規作成'

    fill_in '内容', with: 'とても頑張った'
    fill_in 'タイトル', with: ''
    click_button '登録する'
    assert_selector 'li', exact_text: 'タイトルを入力してください'
  end
end
