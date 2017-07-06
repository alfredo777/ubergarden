class AddNameDowncaseToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :name_downcase_no_characters, :string
  end
end
