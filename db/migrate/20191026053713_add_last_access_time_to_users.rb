class AddLastAccessTimeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :last_access_time, :datetime, default: "1900-01-01 00:00:00"
  end
end
