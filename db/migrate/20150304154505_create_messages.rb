class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :message_guts
      t.references :channel, index: true

      t.timestamps null: false
    end
    add_foreign_key :messages, :channels
  end
end
