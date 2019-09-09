require 'rails_helper'

RSpec.describe 'ログイン時の挙動', type: :system do
  let(:user) { create(:valid_user) }
  
  context '有効な情報が入力された時' do
    example 'ナビゲーションが切り替わり、ユーザーページにリダイレクトされる' do
      visit(login_path)
      fill_in('メールアドレス', with: user.email)
      fill_in('パスワード', with: user.password)
      click_button('ログイン')
      expect(page).to have_content(user.name)
      expect(page).to have_content('アカウント')
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