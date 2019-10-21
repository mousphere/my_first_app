class CreateStocks < ActiveRecord::Migration[5.1]
  def change
    create_table :stocks do |t|
      t.integer :stock_user_id
      t.integer :stocked_article_id

      t.timestamps
    end
    add_index :stocks, :stock_user_id
    add_index :stocks, :stocked_article_id
    add_index :stocks, [:stock_user_id, :stocked_article_id], unique: true
  end
end
