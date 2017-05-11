class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :nombre
      t.float :precio
      t.string :nombre_cientifico
      t.string :luz
      t.string :riego
      t.text :necesidades
      t.text :descripccion
      t.string :tamano

      t.timestamps
    end
  end
end
