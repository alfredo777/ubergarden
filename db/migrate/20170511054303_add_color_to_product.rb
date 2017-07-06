class AddColorToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :color1, :string
    add_column :products, :color2, :string
    add_column :products, :color3, :string
    add_column :products, :color4, :string
    add_column :products, :color5, :string
  end
end
