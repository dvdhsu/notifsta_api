class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :name
      t.string :guid
      t.references :event, index: true

      t.timestamps null: false
    end
    add_foreign_key :channels, :events
    add_index :channels, [:event_id, :name], unique: true
  end
end
