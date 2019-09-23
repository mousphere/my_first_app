require 'rails_helper'

RSpec.describe 'プロフィール編集時の挙動', type: :system do
  let(:user) { create(:valid_user) }
  
  context '有効な情報が入力された時' do
    example '成功メッセージを表示し、ユーザー情報を更新する' do
      visit(edit_user_path(user))
      name = 'hoge'
      email = 'hoge@hoge.com'
      fill_in('ユーザー名', with: name)
      fill_in('メールアドレス', with: email)
      fill_in('パスワード', with: '')
      fill_in('パスワード(確認用にもう1度入力してください)', with: '')
      click_button('変更')
      user.reload
      expect(user.name).to eq name
      expect(user.email).to eq email
      expect(page).to have_css('div.alert-success')
    end
  end
  
  context '無効な情報が入力された時' do
    example 'エラーメッセージを表示して編集フォームを表示する' do
      visit(edit_user_path(user))
      fill_in('ユーザー名', with: '')
      fill_in('メールアドレス', with: user.email)
      fill_in('パスワード', with: '')
      fill_in('パスワード(確認用にもう1度入力してください)', with: '')
      click_button('変更')
      expect(page).to have_css('div.alert-danger')
      expect(page).to have_content('ユーザー情報編集')
    end
  end
end