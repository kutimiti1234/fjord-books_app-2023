# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'alice' }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { 'password' }

    factory :user_without_name, class: User do
      name { nil }
    end
  end
end
