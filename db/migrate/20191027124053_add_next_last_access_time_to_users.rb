class AddNextLastAccessTimeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :next_last_access_time, :datetime
  end
end
