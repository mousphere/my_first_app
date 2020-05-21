class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :content, null: false
      t.bigint :user_id, null: false
      t.bigint :article_id, null: false

      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :article_id
  end
end
