# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { create(:user1) }
  let(:article) { create(:article, user_id: user.id) }

  example '有効なLikeリレーション' do
    like = Like.new(like_user_id: user.id, liked_article_id: article.id)
    expect(like).to be_valid
  end

  context '無効なLikeリレーション' do
    example 'like_user_idのみ' do
      like = Like.new(like_user_id: user.id)
      expect(like).not_to be_valid
    end
    example 'liked_article_idのみ' do
      like = Like.new(liked_article_id: article.id)
      expect(like).not_to be_valid
    end
  end

  context 'ユーザー、記事との依存性チェック' do
    example 'ユーザー削除でストックリレーションも削除' do
      user.likes.create(liked_article_id: article.id)
      expect { user.destroy }.to change { Like.count }.by(-1)
    end
    example '記事削除でストックリレーションも削除' do
      user.likes.create(liked_article_id: article.id)
      expect { article.destroy }.to change { Like.count }.by(-1)
    end
  end
end
