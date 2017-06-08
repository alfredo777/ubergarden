class CreateLineItems < ActiveRecord::Migration[5.0]
  def change
    create_table :line_items do |t|
      t.string :session_token
      t.text :line_items, limit: 4294967296

      t.timestamps
    end
  end
end
