class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :reference
      t.string :purchase_channel
      t.string :client_name
      t.string :address
      t.string :delivery_service
      t.decimal :total_value
      t.text :line_items
      t.string :status

      t.timestamps
    end
  end
end
