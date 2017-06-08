class CreateTagIdAndProductIds < ActiveRecord::Migration[5.0]
  def change
    create_table :tag_id_and_product_ids do |t|
      t.integer :tag_id
      t.integer :product_id

      t.timestamps
    end
  end
end
