class ChangeUrlColumnOnArticles < ActiveRecord::Migration[5.1]
  def up
    change_column_null :articles, :url, false, ''
    change_column :articles, :url, :string, default: ''
  end

  def down
    change_column_null :articles, :url, true, nil
    change_column :articles, :url, :string, default: nil
  end
end
