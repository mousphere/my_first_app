# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'フォロー、フォロワー数リンクの挙動', type: :system do
  let(:user1) { create(:user1) }
  let(:user2) { create(:user2) }
  let(:relationship) { create(:relationship, follower_id: user1.id, followed_id: user2.id) }

  context 'フォロー数リンク押下時' do
    example 'フォロー中ユーザー名が表示される' do
      relationship
      log_in(user1)
      find('#num-of-followings').click
      expect(page).to have_content(user2.name)
    end
  end

  context 'フォロワー数リンク押下時' do
    example 'フォロワー名が表示される' do
      relationship
      log_in(user2)
      find('#num-of-followers').click
      expect(page).to have_content(user1.name)
    end
  end
end
