class CreateImageProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :image_products do |t|
      t.integer :product_id
      t.string :file

      t.timestamps
    end
  end
end
