class AddIndexToComment < ActiveRecord::Migration[5.1]
  def change
    add_index :comments, [:user_id, :article_id], unique: true
  end
end
