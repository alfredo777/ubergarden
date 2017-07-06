class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
      t.string :title
      t.string :downcase_title
      t.string :code

      t.timestamps
    end
  end
end
