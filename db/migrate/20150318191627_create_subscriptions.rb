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
  end
end
