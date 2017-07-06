class AddPublicadoToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :publicado, :boolean, default: false
  end
end
