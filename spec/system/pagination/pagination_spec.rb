# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ページネーション関連', type: :system do
  let(:user) { create(:user1) }
  let(:article) { create(:article, user_id: user.id) }

  context '投稿記事数が5以下' do
    example 'ページネーションが表示されない' do
      create_article(user)
      visit(root_path)
      expect(page).not_to have_content('最後')
    end
  end

  context '投稿記事数が6以上' do
    example 'ページネーションが表示される' do
      create_article(user)
      article
      visit(root_path)
      expect(page).to have_content('最後')
    end
  end
end
