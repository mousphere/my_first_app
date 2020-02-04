# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ユーザー削除時の挙動', type: :system do
  let(:user1) { create(:user1) }
  let(:user2) { create(:user2) }
  let(:test_user) { create(:test_user) }

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

  context 'テストユーザー削除時' do
    example '警告メッセージを表示し、アカウント削除ページにリダイレクトする' do
      log_in(test_user)
      visit(deactivate_user_path(test_user))
      click_link('削除')
      expect(current_path).to eq deactivate_user_path(test_user)
      expect(page).to have_css('div.alert-danger')
    end

    example 'ユーザー登録数が変化しない' do
      log_in(test_user)
      visit(deactivate_user_path(test_user))
      expect { click_link('削除') }.to change(User, :count).by(0)
    end
  end

  context '削除成功時' do
    example 'ユーザー登録数が1減る' do
      log_in(user1)
      visit(deactivate_user_path(user1))
      expect { click_link('削除') }.to change(User, :count).by(-1)
    end

    example '成功メッセージを表示してルートパスにリダイレクトされる' do
      log_in(user1)
      visit(deactivate_user_path(user1))
      click_link('削除')
      expect(current_path).to eq root_path
      expect(page).to have_css('div.alert-success')
    end

    example '関連の記事が全て削除される' do
      log_in(user1)
      create_article(user1)
      visit(deactivate_user_path(user1))
      expect { click_link('削除') }.to change(Article, :count).by(-5)
    end
  end
end
