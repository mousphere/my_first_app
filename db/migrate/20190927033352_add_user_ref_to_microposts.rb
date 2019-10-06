class AddUserRefToMicroposts < ActiveRecord::Migration[5.1]
  def change
    add_reference :microposts, :user, foreign_key: true
    add_index :microposts, [:user_id, :created_at]
  end
end
