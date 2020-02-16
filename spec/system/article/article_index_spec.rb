# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'カテゴリー選択時の挙動', type: :system do
  let(:user) { create(:user1) }

  subject do
    create_article(user)
    visit(root_path)
  end

  example 'ホーム画面では全記事が表示される' do
    subject
    expect(page).to have_css('div.article', count: 5)
  end

  example '該当のカテゴリーリンクをクリックすると、全記事が表示される' do
    subject
    click_link('チョコレート')
    expect(page).to have_css('div.article', count: 5)
  end

  example '該当以外のカテゴリーリンクをクリックすると、記事が表示されない' do
    subject
    click_link('その他')
    expect(page).to have_css('div.article', count: 0)
  end
end
