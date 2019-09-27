class AddContentsInfoToMicroposts < ActiveRecord::Migration[5.1]
  def change
    add_column :microposts, :area, :string
    add_column :microposts, :genre, :string
    add_column :microposts, :image, :string
  end
end
