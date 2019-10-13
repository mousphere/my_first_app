# frozen_string_literal: true

FactoryBot.define do
  sequence :content do |n|
    "#{n}番目の投稿"
  end

  factory :article, class: Article do
    sweet_name { 'チョコレート' }
    genre { 'チョコレート' }
    content
  end
end
