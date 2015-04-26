class AddEventMapUrlToEvents < ActiveRecord::Migration
  def change
    add_column :events, :event_map_url, :string
  end
end
