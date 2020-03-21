# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'フォローユーザー記事ボタンの挙動', type: :system do
  let(:user1) { create(:user1) }
  let(:user2) { create(:user2) }
  let(:relationship) { create(:relationship, follower_id: user1.id, followed_id: user2.id) }
  let(:article) { create(:article, user_id: user2.id) }

  context 'フォローユーザー記事ボタンクリック時' do
    example 'フォローユーザーが投稿している記事が表示される' do
      relationship
      article
      log_in(user1)
      find('#followings-articles').click
      expect(page).to have_css('div.article')
      expect(page).to have_content(user2.name)
    end
  end
end
