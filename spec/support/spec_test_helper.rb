# frozen_string_literal: true

module SpecTestHelpers
  def log_in(user)
    visit(login_path)
    fill_in('メールアドレス', with: user.email)
    fill_in('パスワード', with: user.password)
    click_button('ログイン')
  end

  def log_out
    visit(root_path)
    click_link('mypage')
    click_link('logout')
  end

  def create_article(user)
    (1..5).each do |i|
      create(:article, user_id: user.id, created_at: Time.zone.now + i)
    end
  end
end
