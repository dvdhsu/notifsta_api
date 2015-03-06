class CreateChannelsUsersTable < ActiveRecord::Migration
  def change
    create_table :channels_users do |t|
      t.integer :channel_id
      t.integer :user_id
    end
  end
end
