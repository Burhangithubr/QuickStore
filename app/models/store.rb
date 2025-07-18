class Store < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: "owner_id"

  has_many :store_users, dependent: :destroy
  has_many :staff, through: :store_users, source: :user

  has_many :products, dependent: :destroy
  has_many :orders, dependent: :destroy

  has_many :payment_methods, dependent: :destroy

  validates :name, :contact_info, presence: true
   after_create :ensure_default_payment_method
  protected

  def ensure_default_payment_method
  self.payment_methods.create!(name: "Cash on Delivery", payment_type: :cod)
end

end
