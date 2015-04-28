class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :cover_photo_url
      t.string :facebook_url
      t.string :website_url

      t.datetime :start_time
      t.datetime :end_time
      t.string :description
      t.string :address
      t.float :longitude
      t.float :latitude

      t.timestamps null: false
    end
  end
end
