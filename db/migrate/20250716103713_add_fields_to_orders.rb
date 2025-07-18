class AddFieldsToOrders < ActiveRecord::Migration[8.0]
  def change
    add_reference :orders, :customer, null: false, foreign_key: true
    add_column :orders, :total_amount, :decimal
    add_column :orders, :status, :string
    add_column :orders, :shipping_address, :text
  end
end
