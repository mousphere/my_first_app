require 'rails_helper'

RSpec.describe 'プロフィール編集時の挙動', type: :system do
  let(:user1) { create(:user1) }
  let(:user2) { create(:user2) }
  
  context 'ログインしていない時' do
    example '警告メッセージを表示し、ルートパスにリダイレクトする' do
      visit(edit_user_path(user1))
      expect(current_path).to eq root_path
      expect(page).to have_css('div.alert-danger')
    end
  end
  
  context '別のユーザーの情報を編集しようとした時' do
    example '警告メッセージを表示し、ルートパスにリダイレクトする' do
      log_in(user1)
      visit(edit_user_path(user2))
      expect(current_path).to eq root_path
      expect(page).to have_css('div.alert-danger')
    end
  end
  
  context '有効な情報が入力された時' do
    example '成功メッセージを表示し、ユーザー情報を更新する' do
      log_in(user1)
      visit(edit_user_path(user1))
      name = 'hoge'
      email = 'hoge@hoge.com'
      fill_in('ユーザー名', with: name)
      fill_in('メールアドレス', with: email)
      fill_in('パスワード', with: '')
      fill_in('パスワード(確認用にもう1度入力してください)', with: '')
      click_button('変更')
      user1.reload
      expect(user1.name).to eq name
      expect(user1.email).to eq email
      expect(page).to have_css('div.alert-success')
    end
  end
  
  context '無効な情報が入力された時' do
    example 'エラーメッセージを表示して編集フォームを表示する' do
      log_in(user1)
      visit(edit_user_path(user1))
      fill_in('ユーザー名', with: '')
      fill_in('メールアドレス', with: user1.email)
      fill_in('パスワード', with: '')
      fill_in('パスワード(確認用にもう1度入力してください)', with: '')
      click_button('変更')
      expect(page).to have_css('div.alert-danger')
      expect(page).to have_content('ユーザー情報編集')
    end
  end
end