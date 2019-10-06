require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:user) { create(:user1) }
  let(:article) { create(:article, user_id: user.id) }
    
  context '無効な記事内容' do
    context '1. 商品名が無効' do
      example '商品名が入力されていない' do
        article.sweet_name = ''
        expect(article).not_to be_valid
      end
    end
    context '3. ジャンルが無効' do
      example 'ジャンルが入力されていない' do
        article.genre = ''
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
      create_article(user)
      expect(user.articles.first.content).to eq '5番目の投稿'
    end
end