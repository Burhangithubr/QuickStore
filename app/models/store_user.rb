class StoreUser < ApplicationRecord
  belongs_to :store
  belongs_to :user

   def stock_manager?
    role == "stock_manager"
  end

  def dispatcher?
    role == "dispatcher"
  end
   validates :role, presence: true
end
