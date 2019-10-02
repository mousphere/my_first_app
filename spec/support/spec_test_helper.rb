module SpecTestHelpers
  def log_in(user)
    visit(login_path)
    fill_in('メールアドレス', with: user.email)
    fill_in('パスワード', with: user.password)
    click_button('ログイン')
  end
  
  def create_article(user)
    for i in 1..5 do
      create(:article, user_id: user.id)
    end
  end
end