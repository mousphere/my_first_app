class RemoveOrderOptionFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :order_option, :integer
  end
end
