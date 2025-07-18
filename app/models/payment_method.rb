class PaymentMethod < ApplicationRecord
  belongs_to :store
  has_many :orders


validates :name, :payment_type, presence: true

 def cod?
    payment_type == "cod"
  end

  def mock?
    payment_type == "mock"
  end

end
