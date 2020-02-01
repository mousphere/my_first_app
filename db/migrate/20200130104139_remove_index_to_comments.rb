class RemoveIndexToComments < ActiveRecord::Migration[5.1]
  def change
    remove_index :comments, [:user_id, :article_id]
  end
end
