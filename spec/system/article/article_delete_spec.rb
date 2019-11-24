# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '記事削除ボタン関連の挙動', type: :system do
  let(:user1) { create(:user1) }
  let(:user2) { create(:user2) }
  let(:article) { create(:article, user_id: user1.id) }

  example '削除ボタンを押すと記事が削除される' do
    article
    log_in(user1)
    find('.article-delete-button').click
    expect{ click_button('削除') }.to change(Article, :count).by(-1)
  end

  example '他ユーザーの記事には削除アイコンが表示されない' do
    article
    log_in(user2)
    expect(page).not_to have_css('div.article_delete_button')
  end
end