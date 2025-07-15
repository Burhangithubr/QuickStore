class StoreUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_store
  before_action :ensure_owner

  def new
  end

  def create
    email = params[:email].strip.downcase
    role  = params[:role]

    if email.blank? || role.blank?
      redirect_to store_path(@store), alert: "Email and Role are required."
      return
    end

    user = User.find_by(email: email)

    if user
      if user.invitation_accepted?
        if @store.store_users.exists?(user: user)
          redirect_to store_path(@store), alert: "User is already assigned."
        else
          @store.store_users.create!(user: user, role: role)
          redirect_to store_path(@store), notice: "User assigned successfully."
        end
      else
        redirect_to store_path(@store), alert: "User was invited but hasn't accepted yet."
      end
    else
      # Cache store and role until user accepts
      pending_roles = Rails.cache.read("pending_store_roles:#{email}") || {}
      pending_roles[@store.id] = role
      Rails.cache.write("pending_store_roles:#{email}", pending_roles)

      User.invite!(email: email) do |u|
        u.role = role
      end

      redirect_to store_path(@store), notice: "Invitation sent to #{email}. User will be assigned after accepting."
    end
  end

  private

  def set_store
    @store = Store.find(params[:store_id])
  end

  def ensure_owner
    redirect_to root_path unless current_user.owner?
  end
end
