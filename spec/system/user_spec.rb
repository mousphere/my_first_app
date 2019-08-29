require 'rails_helper'

RSpec.describe 'ユーザー登録時の挙動', type: :system do
  context "有効な情報を送信したとき" do
    example "ユーザーページにリダイレクトされる" do
      visit(new_user_path)
      fill_in("ユーザー名", with: "Test User")
      fill_in("メールアドレス", with: "text@example.com")
      fill_in("パスワード", with: "password")
      fill_in("パスワード(確認用にもう1度入力してください)", with: "password")
      click_button("登録")
      expect(page).to have_css('div.bg-warning')
    end
  end
end