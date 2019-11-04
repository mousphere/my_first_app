class RemoveNextLastAccessTimeFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :next_last_access_time, :datetime
  end
end
