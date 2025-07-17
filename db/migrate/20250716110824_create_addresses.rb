class CreateAddresses < ActiveRecord::Migration[8.0]
  def change
    create_table :addresses do |t|
      t.references :customer, null: false, foreign_key: true
      t.text :full_address
      t.boolean :default

      t.timestamps
    end
  end
end
