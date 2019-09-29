class AddTouristAttractionToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :tourist_attraction, :string
  end
end
