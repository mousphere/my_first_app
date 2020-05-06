# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'コメント削除時の挙動', type: :system do
  let(:user1) { create(:user1) }
  let(:user2) { create(:user2) }
  let(:article) { create(:article, user_id: user1.id) }
  let(:comment) { create(:comment, user_id: user1.id, article_id: article.id) }

  example '削除ボタンを押すとコメントが削除される' do
    comment
    log_in(user1)
    visit(article_path(article))
    expect(page).to have_css('button#comment-delete-icon')
    find('#comment-delete-icon').click
    sleep 1
    expect { find('#comment-delete-button').click }.to change(Comment, :count).by(-1)
  end

  example '他ユーザーの記事にはコメント削除アイコンが表示されない' do
    comment
    log_in(user2)
    visit(article_path(article))
    expect(page).not_to have_css('button#comment-delete-icon')
  end
end
