# frozen_string_literal: true

FactoryBot.define do
  factory :report do
    association :user
    content { 'content' }
    title { 'example' }
  end
end
