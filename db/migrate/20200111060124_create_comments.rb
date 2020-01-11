class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :content, null: false
      t.references :user, foreign_key: true, null: false
      t.references :article, foreign_key: true, null: false

      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :article_id
    add_index :comments, [:user_id, :article_id], unique: true
  end
end
