class AddLikeCountsToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :like_counts, :integer, null: false, default: 0
  end
end
