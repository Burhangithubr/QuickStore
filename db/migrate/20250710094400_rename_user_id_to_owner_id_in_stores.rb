class RenameUserIdToOwnerIdInStores < ActiveRecord::Migration[8.0]
  def change
    rename_column :stores, :user_id, :owner_id
  end
end
