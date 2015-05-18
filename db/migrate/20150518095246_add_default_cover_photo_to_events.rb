class AddDefaultCoverPhotoToEvents < ActiveRecord::Migration
  def change
    change_column_default :events, :cover_photo_url, 'http://cdn.notifsta.com/images/walking.jpg'
  end
end
