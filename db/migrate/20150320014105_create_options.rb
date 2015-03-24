class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.references :notification, index: true
      t.string :option_guts

      t.timestamps null: false
    end
    add_foreign_key :options, :notifications
  end
end
