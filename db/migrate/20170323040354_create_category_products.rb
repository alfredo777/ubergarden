class CreateCategoryProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :category_products do |t|
      t.string :nombre
      t.integer :categorico_id
      t.string :categorico_type
      t.boolean :sub_categoria

      t.timestamps
    end
  end
end
