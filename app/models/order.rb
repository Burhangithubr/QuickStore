class Order < ApplicationRecord

  belongs_to :store
  belongs_to :customer
  has_many :order_items, dependent: :destroy
  belongs_to :payment_method
   
  before_validation :set_status_based_on_payment_method, if: -> { payment_method.present? && status.blank? }

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

  private

  def set_status_based_on_payment_method
    if payment_method.mock?
      self.status = "confirmed"
    elsif payment_method.cod?
      self.status = "pending"
    end
  end
end
