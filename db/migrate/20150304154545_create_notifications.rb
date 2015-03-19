class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :notification_guts
      t.string :type
      t.references :channel, index: true

      t.timestamps null: false
    end
    add_foreign_key :notifications, :channels
  end
end
