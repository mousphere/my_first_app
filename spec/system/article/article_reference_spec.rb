# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '記事検索フォーム利用時の挙動', type: :system do
  let(:user) { create(:user1) }
  let(:another_article) { create(:article, user_id: user.id, sweet_name: 'おいしいチョコ') }

  context 'キーワードを入力して検索ボタンを押下した時' do
    example 'キーワードを含む商品名の記事が全てヒットする' do
      create_article(user)
      another_article
      log_in(user)
      visit(root_path)

      fill_in('search_field', with: 'テスト')
      click_button('検索')
      expect(page).to have_css('div.article', count: 5)
      fill_in('search_field', with: 'おいしい')
      click_button('検索')
      expect(page).to have_css('div.article', count: 1)
    end
  end
end
