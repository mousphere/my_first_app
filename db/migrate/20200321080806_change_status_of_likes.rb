class ChangeStatusOfLikes < ActiveRecord::Migration[5.1]
  def change
    change_column_null :likes, :like_user_id, false
    change_column_null :likes, :liked_article_id, false
  end
end
