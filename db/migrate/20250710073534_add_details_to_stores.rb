class AddDetailsToStores < ActiveRecord::Migration[8.0]
  def change
    add_column :stores, :description, :text
    add_column :stores, :contact_info, :string
  end
end
