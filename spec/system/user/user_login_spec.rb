# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ログイン時の挙動', type: :system do
  let(:user) { create(:user1) }
  let(:test_user) { create(:test_user) }

  context 'テストユーザーとしてログイン' do
    example 'テストユーザー用ログインボタンのクリックのみでログイン可能' do
      test_user
      visit(login_path)
      find('a.test-user-button').click
      expect(page).to have_content(test_user.name)
    end
  end

  context '有効な情報が入力された時' do
    example 'ナビゲーションが切り替わり、ユーザーページにリダイレクトされる' do
      log_in(user)
      expect(page).to have_content(user.name)
      expect(page).to have_content('アカウント')
    end

    example 'ログイン後、ログアウトリンクをクリックするとセッションが切断される' do
      log_in(user)
      visit(root_path)
      click_link('アカウント')
      click_link('ログアウト')
      expect(page).to have_content('ログイン')
    end
  end

  context '無効な情報が入力された時' do
    example 'エラーメッセージを表示してログインフォームを表示する' do
      visit(login_path)
      fill_in('メールアドレス', with: user.email)
      fill_in('パスワード', with: '')
      click_button('ログイン')
      expect(page).to have_css('div.alert-danger')
      expect(page).to have_content('ログイン')
    end
  end
end
