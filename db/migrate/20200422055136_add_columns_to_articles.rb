class AddColumnsToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :shop, :string
    add_column :articles, :prefecture, :string
    add_column :articles, :address, :string
  end
end
