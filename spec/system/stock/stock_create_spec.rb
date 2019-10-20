# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '記事ストック時の挙動', type: :system do
  let(:user1) { create(:user1) }
  let(:user2) { create(:user2) }
  let(:article) { create(:article, user_id: user2.id) }


  context 'ストックボタンを押した時' do
    before do
      @article = article
    end

    example 'ストックが生成され、ボタン表示が切り替わる' do
      log_in(user1)
      click_link('ホーム')
      expect(Stock.count).to eq(0)
      click_button('ストックする')
      sleep 1
      expect(page).to have_content('ストック解除')
      expect(Stock.count).to eq(1)
    end
    
    example 'マイページのストック記事に反映される' do
      log_in(user1)
      click_link('ホーム')
      click_button('ストックする')
      visit(user_path(user1))
      click_link('ストック記事')
      expect(page).to have_content(@article.sweet_name)
    end
  end

  context 'ストックがある時' do
    before do
      create(:stock, stock_user_id: user1.id, stocked_article_id: article.id)
    end
    example 'ストック解除ボタンを押すとストックされ、ボタン表示が切り替わる' do
      log_in(user1)
      click_link('ホーム')
      expect(Stock.count).to eq(1)
      click_button('ストック解除')
      expect(page).to have_content('ストックする')
      expect(Stock.count).to eq(0)
    end
  end
end
