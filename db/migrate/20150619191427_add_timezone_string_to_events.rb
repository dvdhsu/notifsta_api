class AddTimezoneStringToEvents < ActiveRecord::Migration
  def change
    add_column :events, :timezone, :string, required: true, default: "Europe/London"
  end
end
