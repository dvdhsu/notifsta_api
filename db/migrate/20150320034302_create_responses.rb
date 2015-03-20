class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.references :option, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :responses, :options
    add_foreign_key :responses, :users
  end
end
