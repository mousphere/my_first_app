class AddRemoteImageUrlToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :remote_image_url, :string
  end
end