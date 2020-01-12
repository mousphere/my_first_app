# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user1) }
  let(:article) { create(:article, user_id: user.id) }

  context '無効なコメント内容' do
    example 'user_idがない' do
      comment = Comment.new(article_id: article.id, content: 'hoge')
      expect(comment).not_to be_valid
    end

    example 'article_idがない' do
      comment = Comment.new(user_id: user.id, content: 'hoge')
      expect(comment).not_to be_valid
    end

    example 'コメントが入力されていない' do
      content = ''
      comment = Comment.new(user_id: user.id, article_id: article.id, content: content)
      expect(comment).not_to be_valid
    end

    example 'コメント内容が301文字以上' do
      content = 'hoge' * 75 + '!'
      comment = Comment.new(user_id: user.id, article_id: article.id, content: content)
      expect(comment).not_to be_valid
    end
  end

  context '有効なコメント内容' do
    example 'user_id, article_idが存在し、コメントが300文字以内' do
      content = 'hoge' * 75
      comment = Comment.new(user_id: user.id, article_id: article.id, content: content)
      expect(comment).to be_valid
    end
  end

  context 'ユーザー、記事との依存性チェック' do
    subject { user.comments.create(article_id: article.id, content: 'hoge') }

    example 'ユーザー削除でコメントも削除' do
      subject
      expect { user.destroy }.to change { Comment.count }.by(-1)
    end

    example '記事削除でコメントも削除' do
      subject
      expect { article.destroy }.to change { Comment.count }.by(-1)
    end
  end
end
