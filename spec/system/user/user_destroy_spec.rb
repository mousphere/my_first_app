require 'rails_helper'

RSpec.describe 'ユーザー削除時の挙動', type: :system do
  let(:user1) { create(:user1) }
  let(:user2) { create(:user2) }
  
  context 'ログインしていない時' do
    example '警告メッセージを表示し、ルートパスにリダイレクトする' do
      visit(deactivate_user_path(user1))
      expect(current_path).to eq root_path
      expect(page).to have_css('div.alert-danger')
    end
  end
  
  context '別のユーザーを削除しようとした時' do
    example '警告メッセージを表示し、ルートパスにリダイレクトする' do
      log_in(user1)
      visit(deactivate_user_path(user2))
      expect(current_path).to eq root_path
      expect(page).to have_css('div.alert-danger')
    end
  end
  
  context '自分のアカウントを削除する' do
    example 'ユーザー登録数が1減る' do
      log_in(user1)
      visit(deactivate_user_path(user1))
      expect{ click_link('削除') }.to change(User, :count).by(-1)
    end
    
    example '成功メッセージを表示してルートパスにリダイレクトされる' do
      log_in(user1)
      visit(deactivate_user_path(user1))
      click_link('削除')
      expect(current_path).to eq root_path
      expect(page).to have_css('div.alert-success')
    end
  end
end