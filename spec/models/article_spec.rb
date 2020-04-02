# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:user) { create(:user1) }
  let(:article) { create(:article, user_id: user.id) }

  context '有効な記事内容' do
    example '有効なURL' do
      article.url = 'http://yahoo.co.jp'
      expect(article).to be_valid
    end
  end

  context '無効な記事内容' do
    context '1. 商品名が無効' do
      example '商品名が入力されていない' do
        article.sweet_name = ''
        expect(article).not_to be_valid
      end
    end
    context '2. 記事内容が無効' do
      example '記事内容が入力されていない' do
        article.content = ''
        expect(article).not_to be_valid
      end
    end
    context '3. ジャンルが無効' do
      example 'ジャンルが入力されていない' do
        article.genre = ''
        expect(article).not_to be_valid
      end
    end
    context '4. URLが無効' do
      example 'スキームが正しくない' do
        article.url = 'htt://yahoo.co.jp'
        expect(article).not_to be_valid
      end
      example 'スキーム以下がない' do
        article.url = 'http://'
        expect(article).not_to be_valid
      end
    end
  end
end
