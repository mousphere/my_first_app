FactoryBot.define do
  sequence :content do |n|
    "#{n}番目の投稿"
  end
  
  factory :article, class: Article do
    tourist_attraction { '浅草寺' }
    area { '東京都' }
    genre { '歴史' }
    content
  end
end