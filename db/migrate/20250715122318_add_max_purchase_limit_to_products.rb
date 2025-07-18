class AddMaxPurchaseLimitToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :max_purchase_limit, :integer
  end
end
