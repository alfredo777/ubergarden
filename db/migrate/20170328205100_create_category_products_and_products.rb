class CreateCategoryProductsAndProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :category_products_and_products do |t|
      t.integer :category_product_id
      t.integer :product_id

      t.timestamps
    end
  end
end
