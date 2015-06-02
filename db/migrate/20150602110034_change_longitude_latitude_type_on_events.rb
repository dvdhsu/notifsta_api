class ChangeLongitudeLatitudeTypeOnEvents < ActiveRecord::Migration
  def change
    change_column :events, :longitude, :decimal, precision: 15, scale: 10
    change_column :events, :latitude, :decimal, precision: 15, scale: 10
  end
end
