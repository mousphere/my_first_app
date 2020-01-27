# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'コメント投稿時の挙動', type: :system do
  let(:user) { create(:user1) }
  let(:article) { create(:article, user_id: user.id) }

  context 'ログインしていない時' do
    example '警告メッセージを表示してルートパスにリダイレクトする' do
      visit(new_article_comment_path(article_id: article.id))
      expect(current_path).to eq root_path
      expect(page).to have_css('div.alert-danger')
    end
  end

  # ログイン済みユーザーにてコメントフォームよりコメントを送信
  subject(:content) do
    log_in(user)
    visit(new_article_comment_path(article_id: article.id))
    fill_in('comment-area', with: content)
    click_button('送信')
  end

  context 'コメント投稿成功時' do
    let(:content) { '食べたい' }

    example '成功メッセージを表示し、記事詳細ページに移る' do
      subject
      expect(current_path).to eq article_path(article)
      expect(page).to have_css('div.alert-success')
    end

    example 'コメントレコード数が1増える' do
      expect { subject }.to change(Comment, :count).by(1)
    end
  end

  context 'コメント投稿失敗時' do
    let(:content) { '' }

    example 'エラーメッセージを表示して、コメント投稿フォームを表示する' do
      subject
      expect(page).to have_css('div.comment-form')
      expect(page).to have_css('div.alert-danger')
    end

    example '記事レコード数が変化しない' do
      expect { subject }.to change(Comment, :count).by(0)
    end
  end
end
