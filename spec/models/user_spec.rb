# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#name_or_email' do
    context 'ユーザーが名前を登録している場合' do
      user_with_name = FactoryBot.build(:user)
      it '名前を答える' do
        expect(user_with_name.name_or_email).to eq user_with_name.name
      end
    end

    context 'ユーザーが名前を登録していない場合' do
      user_without_name = FactoryBot.build(:user_without_name)
      it 'メールアドレスを答える' do
        expect(user_without_name.name_or_email).to eq user_without_name.email
      end
    end
  end
end
