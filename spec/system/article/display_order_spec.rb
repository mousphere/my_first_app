# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '記事表示順に関する挙動', type: :system do
  let(:user) { create(:user1) }
  before do
    create_article(user)
  end

  context 'ユーザーログイン時' do
    before do
      log_in(user)
      visit(root_path)
    end

    example '最初は新しい投稿順に表示されている' do
      expect(first('.content')).to have_content '5番目の投稿'
    end

    example '新しい投稿順への切り替え' do
      click_button('新しい投稿順')
      sleep 1
      expect(first('.content')).to have_content '5番目の投稿'
    end

    example 'いいね多い順への切り替え' do
      click_button('いいね多い順')
      sleep 1
      expect(first('.content')).to have_content '1番目の投稿'
    end
  end

  context 'ログインしていない時' do
    before do
      visit(root_path)
    end

    example '最初は新しい投稿順に表示されている' do
      expect(first('.content')).to have_content '5番目の投稿'
    end

    example '新しい投稿順への切り替え' do
      click_button('新しい投稿順')
      sleep 1
      expect(first('.content')).to have_content '5番目の投稿'
    end

    example 'いいね多い順への切り替え' do
      click_button('いいね多い順')
      sleep 1
      expect(first('.content')).to have_content '1番目の投稿'
    end
  end
end
