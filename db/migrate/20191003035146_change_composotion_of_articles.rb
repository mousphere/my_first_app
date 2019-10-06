class ChangeComposotionOfArticles < ActiveRecord::Migration[5.1]
  def change
    rename_column :articles, :tourist_attraction, :sweet_name
    remove_column :articles, :area, :string
  end
end
