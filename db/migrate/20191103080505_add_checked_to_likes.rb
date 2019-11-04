class AddCheckedToLikes < ActiveRecord::Migration[5.1]
  def change
    add_column :likes, :checked?, :boolean, default: false, null: false
  end
end
