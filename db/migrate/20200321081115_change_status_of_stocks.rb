class ChangeStatusOfStocks < ActiveRecord::Migration[5.1]
  def change
    change_column_null :stocks, :stock_user_id, false
    change_column_null :stocks, :stocked_article_id, false
  end
end
