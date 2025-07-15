class Store < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: "owner_id"

  has_many :store_users, dependent: :destroy
  has_many :staff, through: :store_users, source: :user

  has_many :products, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :name, :contact_info, presence: true
end
