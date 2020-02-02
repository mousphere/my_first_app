# frozen_string_literal: true

FactoryBot.define do
  factory :comment, class: Comment do
    content { 'テスト' }
  end
end
