class RemoveStringFromStoreUsers < ActiveRecord::Migration[8.0]
  def change
    remove_column :store_users, :string, :string
  end
end
