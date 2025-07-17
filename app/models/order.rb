class Order < ApplicationRecord

  belongs_to :store
  belongs_to :customer
  has_many :order_items, dependent: :destroy
   
  def pending?
    status == "pending"
  end

  def confirmed?
    status == "confirmed"
  end

  def shipped?
    status == "shipped"
  end

  def delivered?
    status == "delivered"
  end
  
end
