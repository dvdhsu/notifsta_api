class FixTwitterColumnName < ActiveRecord::Migration
  def change
    rename_column :events, :twitter_hashtag, :twitter_widget_id
  end
end
