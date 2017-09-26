class AddOfertaToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :oferta, :integer, defuault: 0
  end
end

