class AddPaymentMethodToOrders < ActiveRecord::Migration[8.0]
  def change
    add_reference :orders, :payment_method, foreign_key: true
  end
end
