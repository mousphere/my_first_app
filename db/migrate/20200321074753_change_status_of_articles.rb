class ChangeStatusOfArticles < ActiveRecord::Migration[5.1]
  def change
    change_column_null :articles, :content, false
    change_column_null :articles, :user_id, false
    change_column_null :articles, :genre, false
    change_column_null :articles, :sweet_name, false
  end
end
