# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'フォローボタン関連の挙動', type: :system do
  let(:user1) { create(:user1) }
  let(:user2) { create(:user2) }

  context 'マイページアクセス時' do
    example 'フォロー情報は表示されるが、フォローボタンが表示されない' do
      log_in(user1)
      expect(page).to have_css('span.follow-info')
      expect(page).not_to have_css('button#follow-button')
    end
  end

  context '他ユーザーページアクセス時' do
    example 'フォロー情報、フォローボタンが表示される' do
      log_in(user1)
      visit(user_path(user2))
      expect(page).to have_css('span.follow-info')
      expect(page).to have_css('button#follow-button')
    end
  end

  context 'フォローボタン押下時' do
    example 'フォローリレーションが生成される' do
      log_in(user1)
      visit(user_path(user2))
      expect(Relationship.count).to eq(0)
      find('#follow-button').click
      sleep 1
      expect(Relationship.count).to eq(1)
    end

    example 'フォロワー数表示が変化する' do
      log_in(user1)
      visit(user_path(user2))
      expect(page).to have_content('フォロワー 0')
      find('#follow-button').click
      sleep 1
      expect(page).to have_content('フォロワー 1')
    end
  end
end
