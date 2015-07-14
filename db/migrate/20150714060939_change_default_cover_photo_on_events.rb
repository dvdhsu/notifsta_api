class ChangeDefaultCoverPhotoOnEvents < ActiveRecord::Migration
  def change
    change_column_default :events, :cover_photo_url, nil
  end
end
