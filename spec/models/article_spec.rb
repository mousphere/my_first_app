require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:user) { create(:user1) }
  let(:article) { create(:article, user_id: user.id) }
    
  context '無効な記事内容' do
    context '1. 観光スポットが無効' do
      example '観光スポット名が入力されていない' do
        article.tourist_attraction = ''
        expect(article).not_to be_valid
      end
    end
    context '2. 記事内容が無効' do
      example '記事内容が入力されていない' do
        article.content = ''
        expect(article).not_to be_valid
      end
    end
  end
  
  context '記事の順番'
    example '投稿時刻の降順になっているか' do
      user1 = user
      create_article(user1)
      expect(user1.articles.first.content).to eq '5番目の投稿'
    end
end