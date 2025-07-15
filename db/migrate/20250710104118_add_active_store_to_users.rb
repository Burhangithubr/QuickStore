class AddActiveStoreToUsers < ActiveRecord::Migration[8.0]
  def change
    add_reference :users, :active_store, foreign_key: { to_table: :stores }
  end
end
