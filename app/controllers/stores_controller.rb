class StoresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_store, only: [:show, :edit, :update]
  before_action :authorize_owner!

def show
  @store = Store.find(params[:id])
end

  def edit; end

  def new
    @store = current_user.stores.build
  end

  def create
    @store = current_user.stores.build(store_params)
    if @store.save
      redirect_to owner_dashboard_path, notice: "Store created successfully."
    else
      render :new, alert: "Failed to create store."
    end
  end

  def update
    if @store.update(store_params)
      redirect_to owner_dashboard_path, notice: "Store updated successfully."
    else
      render :edit
    end
  end

  private

  def set_store
     @store = current_user.stores.find(params[:id])
  end

  def authorize_owner!
    redirect_to root_path, alert: "Not authorized" unless current_user.owner?
  end

  def store_params
    params.require(:store).permit(:name, :description, :contact_info)
  end
end
