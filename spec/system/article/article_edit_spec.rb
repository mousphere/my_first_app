# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '記事投稿時の挙動', type: :system do
  let(:user1) { create(:user1) }
  let(:user2) { create(:user2) }
  let(:article) { create(:article, user_id: user1.id) }

  context '有効な編集内容の時' do
    example '記事が更新され、成功メッセージが表示される' do
      article
      log_in(user1)
      click_link('編集')
      fill_in('紹介文', with: '記事を更新しました')
      click_button('更新する')
      expect(current_path).to eq article_path(article)
      expect(page).to have_css('div.alert-success')
    end
  end

  context '無効な編集内容の時はエラーメッセージを表示して、記事編集フォームを表示する' do
    example '商品名が空白の時' do
      article
      log_in(user1)
      click_link('編集')
      fill_in('商品名', with: '')
      click_button('更新する')
      expect(page).to have_content('記事編集')
      expect(page).to have_css('div.alert-danger')
    end

    example '紹介文が空白の時' do
      article
      log_in(user1)
      click_link('編集')
      fill_in('紹介文', with: '')
      click_button('更新する')
      expect(page).to have_content('記事編集')
      expect(page).to have_css('div.alert-danger')
    end
  end
  
  context 'カレントユーザーが作成した記事がない時' do
    example '他ユーザー作成記事の中に編集リンクが表示されない' do
      log_in(user2)
      visit(root_path)
      expect(page).to have_content(article.sweet_name)
      expect(page).not_to have_content('編集')
    end
  end

  context 'ログインしていない時' do
    example '警告メッセージを表示してルートパスにリダイレクトする' do
      visit(edit_article_path(article))
      expect(current_path).to eq root_path
      expect(page).to have_css('div.alert-danger')
    end
  end

  context '記事作成者以外が編集しようとした時' do
    example '警告メッセージを表示してルートパスにリダイレクトする' do
      log_in(user2)
      visit(edit_article_path(article))
      expect(current_path).to eq root_path
      expect(page).to have_css('div.alert-danger')
    end
  end
end
