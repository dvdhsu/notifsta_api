class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :event, index: true
      t.references :user, index: true
      t.boolean :admin, default: false

      t.timestamps null: false
    end
    add_foreign_key :subscriptions, :events
    add_foreign_key :subscriptions, :users
    add_index :subscriptions, [:user_id, :event_id], unique: true
  end
end
