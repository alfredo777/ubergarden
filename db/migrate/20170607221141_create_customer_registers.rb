class CreateCustomerRegisters < ActiveRecord::Migration[5.0]
  def change
    create_table :customer_registers do |t|
      t.string :customer_token_conekta
      t.string :customer_email
      t.string :customer_phone
      t.string :customer_name
      t.integer :user_id

      t.timestamps
    end
  end
end
