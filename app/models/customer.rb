class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

         has_one :cart
         has_many :orders
         has_many :addresses

          def default_address
    addresses.find_by(default: true)
  end

end
