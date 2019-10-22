class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.integer :like_user_id
      t.integer :liked_article_id

      t.timestamps
    end
    add_index :likes, :like_user_id
    add_index :likes, :liked_article_id
    add_index :likes, [:like_user_id, :liked_article_id], unique: true
  end
end
