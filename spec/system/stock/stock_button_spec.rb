# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ストックボタン関連の挙動', type: :system do
  let(:user1) { create(:user1) }
  let(:user2) { create(:user2) }
  let(:article) { create(:article, user_id: user2.id) }

  context 'ログインせずにストックボタンを押した時' do
    example 'ログインを求められる' do
      article
      visit(root_path)
      find('.stock-button').click
      expect(page.driver.browser.switch_to.alert.text).to eq 'ログインが必要です'
    end
    example 'ストックが生成されない' do
      article
      visit(root_path)
      expect { find('.stock-button').click }.to change(Stock, :count).by(0)
    end
  end

  context 'ストックボタンを押した時' do
    before do
      @article = article
    end

    example 'ストックが生成される' do
      log_in(user1)
      click_link('ホーム')
      expect(Stock.count).to eq(0)
      find('.stock-button').click
      sleep 1
      expect(Stock.count).to eq(1)
    end

    example 'マイページのストック記事に反映される' do
      log_in(user1)
      click_link('ホーム')
      find('.stock-button').click
      visit(user_path(user1))
      click_link('ストック記事')
      expect(page).to have_content(@article.sweet_name)
    end
  end

  context 'ストックがある時' do
    before do
      create(:stock, stock_user_id: user1.id, stocked_article_id: article.id)
    end
    example 'ボタンを押すとストックが解除される' do
      log_in(user1)
      click_link('ホーム')
      expect(Stock.count).to eq(1)
      find('.stock-button').click
      sleep 1
      expect(Stock.count).to eq(0)
    end
  end
end
