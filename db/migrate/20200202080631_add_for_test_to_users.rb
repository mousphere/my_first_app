class AddForTestToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :for_test, :boolean, null: false, default: false
  end
end
