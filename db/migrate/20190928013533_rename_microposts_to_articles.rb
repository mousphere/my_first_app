class RenameMicropostsToArticles < ActiveRecord::Migration[5.1]
  def change
    rename_table :microposts, :articles
  end
end
