# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '記事検索フォーム利用時の挙動', type: :system do
  let(:user) { create(:user1) }
  let(:another_article) do
    create(:article, user_id: user.id,
                     sweet_name: 'おいしいチョコ',
                     prefecture: 'tokyo')
  end

  subject do
    create_article(user)
    another_article
    log_in(user)
    visit(root_path)
  end

  example '検索を実行しない時はホーム画面で全記事が表示される' do
    subject
    expect(page).to have_css('div.article', count: 6)
  end

  context 'ジャンルを選択して検索ボタンを押下した時' do
    example '選択したジャンルに該当する記事が表示される' do
      subject

      within '#q_genre_eq' do
        select 'チョコレート'
      end
      find('#search-button').click
      expect(page).to have_css('div.article', count: 6)

      within '#q_genre_eq' do
        select 'その他'
      end
      find('#search-button').click
      expect(page).to have_css('div.article', count: 0)
    end
  end

  context '都道府県を選択して検索ボタンを押下した時' do
    example '選択したジャンルに該当する記事が表示される' do
      subject

      within '#q_prefecture_eq' do
        select '東京都'
      end
      find('#search-button').click
      expect(page).to have_css('div.article', count: 1)
    end
  end

  context 'キーワードを入力して検索ボタンを押下した時' do
    example 'キーワードを含む商品名の記事が全てヒットする' do
      subject

      fill_in('sweet-name-search', with: 'テスト')
      find('#search-button').click
      expect(page).to have_css('div.article', count: 5)

      fill_in('sweet-name-search', with: 'おいしい')
      find('#search-button').click
      expect(page).to have_css('div.article', count: 1)
    end
  end
end
