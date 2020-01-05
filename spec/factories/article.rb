# frozen_string_literal: true

FactoryBot.define do
  sequence :content do |n|
    i = if n % 5 == 0
          5
        else
          n % 5
        end

    "#{i}番目の投稿"
  end

  sequence :like_counts do |n|
    5 if n % 5 == 1
  end

  factory :article, class: Article do
    sweet_name { 'チョコレート' }
    genre { 'チョコレート' }
    content
  end
end
