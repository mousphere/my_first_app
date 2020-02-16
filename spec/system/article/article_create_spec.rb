# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '記事投稿時の挙動', type: :system do
  let(:user) { create(:user1) }
  let(:article) { build(:article, user_id: user.id) }

  subject do
    log_in(user)
    click_link('記事投稿')
    fill_in('商品名', with: article.sweet_name)
    select('チョコレート', from: 'ジャンル')
    fill_in('紹介文', with: article.content)
    click_button('投稿する')
  end

  context 'ログインしていない時' do
    example '警告メッセージを表示してルートパスにリダイレクトする' do
      visit(new_article_path)
      expect(current_path).to eq root_path
      expect(page).to have_css('div.alert-danger')
    end
  end

  context '記事投稿成功時' do
    example '成功メッセージを表示し、ユーザーページに戻る' do
      subject
      expect(current_path).to eq user_path(user)
      expect(page).to have_css('div.alert-success')
    end

    example 'ユーザーページに投稿した記事が表示される' do
      subject
      expect(page).to have_content('商品名：' + article.sweet_name)
    end

    example 'ルートページに投稿した記事が表示される' do
      subject
      visit(root_path)
      expect(page).to have_content('商品名：' + article.sweet_name)
    end

    example '記事レコード数が1増える' do
      expect { subject }.to change(Article, :count).by(1)
    end
  end

  context '記事投稿失敗時' do
    before do
      article.sweet_name = ''
    end

    example 'エラーメッセージを表示して、記事投稿フォームを表示する' do
      subject
      expect(page).to have_content('記事投稿')
      expect(page).to have_css('div.alert-danger')
    end
    example '記事レコード数が変化しない' do
      expect { subject }.to change(Article, :count).by(0)
    end
  end
end
