class User < ApplicationRecord
  # Devise modules
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  # Associations
  has_many :stores, foreign_key: :owner_id, dependent: :destroy
  belongs_to :active_store, class_name: "Store", optional: true
  has_many :store_users
  has_many :assigned_stores, through: :store_users, source: :store

  # Validations
  validates :role, presence: true

  # Callbacks
  after_initialize :set_default_role, if: :new_record?
  after_create :assign_default_store_if_owner
  after_invitation_accepted :assign_to_pending_stores

  # Role check helpers
  def owner?
    role == "owner"
  end
  
  def customer?
    role == "customer"
  end

  def stock_manager?
    role == "stock_manager"
  end

  def dispatcher?
    role == "dispatcher"
  end

  private

  def set_default_role
    self.role ||= "owner"
  end

  def assign_default_store_if_owner
    return unless owner?

    default_store = stores.create!(
      name: "#{email.split('@').first.titleize}'s Store",
      description: "Default store for #{email}",
      contact_info: "Not provided"
    )

    update!(active_store: default_store)
  end

 def assign_to_pending_stores
  Rails.logger.debug ">>> assign_to_pending_stores triggered for #{email}"

  pending_roles = Rails.cache.read("pending_store_roles:#{email}")
  Rails.logger.debug ">>> Pending roles: #{pending_roles.inspect}"

  if pending_roles.present?
    pending_roles.each do |store_id, role|
      store = Store.find_by(id: store_id)
      if store
        Rails.logger.debug ">>> Assigning #{email} to store #{store.id} as #{role}"
        store.store_users.create!(user: self, role: role)
      end
    end

    Rails.logger.debug ">>> Deleting pending role cache for #{email}"
    Rails.cache.delete("pending_store_roles:#{email}")
  else
    Rails.logger.debug ">>> No pending roles found for #{email}"
  end
end


end
