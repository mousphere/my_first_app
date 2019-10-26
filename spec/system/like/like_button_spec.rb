# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'いいねボタン関連の挙動', type: :system do
  let(:user1) { create(:user1) }
  let(:user2) { create(:user2) }
  let(:article) { create(:article, user_id: user2.id) }

  context 'ログインせずにいいねボタンを押した時' do
    example 'ログインを求められる' do
      article
      visit(root_path)
      find('.like-button').click
      expect(page.driver.browser.switch_to.alert.text).to eq 'ログインが必要です'
    end
    example 'いいねリレーションが生成されない' do
      article
      visit(root_path)
      expect { find('.stock-button').click }.to change(Like, :count).by(0)
    end
  end

  context 'いいねボタンを押した時' do
    before do
      article
    end

    example 'いいねリレーションが生成される' do
      log_in(user1)
      click_link('ホーム')
      expect(Like.count).to eq(0)
      find('.like-button').click
      sleep 1
      expect(Like.count).to eq(1)
    end

    example 'いいね数が0から1に変化する' do
      log_in(user1)
      click_link('ホーム')
      expect(find('.like-count').text).to eq '0'
      find('.like-button').click
      sleep 1
      expect(find('.like-count').text).to eq '1'
    end
  end

  context 'いいねされている時にボタンを押した時' do
    before do
      create(:like, like_user_id: user1.id, liked_article_id: article.id)
    end
    example 'ボタンを押すといいねリレーションが削除される' do
      log_in(user1)
      click_link('ホーム')
      expect(Like.count).to eq(1)
      find('.like-button').click
      expect(Like.count).to eq(0)
    end

    example 'いいね数が1から0に変化する' do
      log_in(user1)
      click_link('ホーム')
      expect(find('.like-count').text).to eq '1'
      find('.like-button').click
      sleep 1
      expect(find('.like-count').text).to eq '0'
    end
  end

  example 'ページアクセス時に累計いいね数が表示される' do
    create(:like, like_user_id: user1.id, liked_article_id: article.id)
    create(:like, like_user_id: user2.id, liked_article_id: article.id)
    visit(root_path)
    expect(find('.like-count').text).to eq '2'
  end
end
