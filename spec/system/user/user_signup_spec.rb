require 'rails_helper'

RSpec.describe 'ユーザー登録時の挙動', type: :system do
  let(:user) { build(:user1) }
  
  subject { visit(new_user_path)
              fill_in('ユーザー名', with: user.name)
              fill_in('メールアドレス', with: user.email)
              fill_in('パスワード', with: user.password)
              fill_in('パスワード(確認用にもう1度入力してください)', with: user.password_confirmation)
              click_button('登録')
          }
  
  context '有効な情報を送信したとき' do
    example 'ユーザーページにリダイレクトされる' do
      subject
      expect(page).to have_content(user.name)
    end
    
    example '自動的にログインする' do
      subject
      expect(page).to have_content('アカウント')
    end
    
    example 'ユーザーレコード数が１増える' do
      expect { subject }.to change(User, :count).by(1)
    end
  end
  
  context '無効な情報を送信したとき' do
    before do
      # ユーザー名を無効な値に変更する
      user.name = ''
    end
    
    example 'エラーメッセージを表示して登録フォームを表示する' do
      subject
      expect(page).to have_content('新規登録')
      expect(page).to have_css('div#error_explanation')
    end
    
    example 'ユーザーレコード数が変化しない' do
      expect{ subject }.to change(User, :count).by(0)
    end
  end
end