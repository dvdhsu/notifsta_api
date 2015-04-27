class CreateSubevents < ActiveRecord::Migration
  def change
    create_table :subevents do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.references :event, index: true
      t.string :name
      t.string :location
      t.string :description
    end
    add_foreign_key :subevents, :events
  end
end
