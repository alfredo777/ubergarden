class CreateProductosInLines < ActiveRecord::Migration[5.0]
  def change
    create_table :productos_in_lines do |t|
      t.string :session_token
      t.text :productos_in_line, limit: 4294967296

      t.timestamps
    end
  end
end
