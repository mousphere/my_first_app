# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Stock, type: :model do
  let(:user) { create(:user1) }
  let(:article) { create(:article, user_id: user.id) }

  example '有効なStockリレーション' do
    stock = Stock.new(stock_user_id: user.id, stocked_article_id: article.id)
    expect(stock).to be_valid
  end

  context '無効なStockリレーション' do
    example 'stock_user_idのみ' do
      stock = Stock.new(stock_user_id: user.id)
      expect(stock).not_to be_valid
    end
    example 'stocked_article_idのみ' do
      stock = Stock.new(stocked_article_id: article.id)
      expect(stock).not_to be_valid
    end
  end

  context 'ユーザー、記事との依存性チェック' do
    example 'ユーザー削除でストックも削除' do
      user.stocks.create(stocked_article_id: article.id)
      expect { user.destroy }.to change { Stock.count }.by(-1)
    end
    example '記事削除でストックも削除' do
      user.stocks.create(stocked_article_id: article.id)
      expect { article.destroy }.to change { Stock.count }.by(-1)
    end
  end
end
