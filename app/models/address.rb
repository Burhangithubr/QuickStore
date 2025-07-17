class Address < ApplicationRecord
  belongs_to :customer
  before_save :ensure_single_default

  private

  def ensure_single_default
    if default
      # Only update other addresses, not this one
      customer.addresses.where.not(id: id).update_all(default: false)
    end
  end
end
