# app/controllers/customers/addresses_controller.rb
class Customers::AddressesController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_address, only: [:edit, :update, :destroy, :make_default]

  def index
    @addresses = current_customer.addresses
  end

  def new
    @address = current_customer.addresses.build
  end

  def create
    @address = current_customer.addresses.build(address_params)
    if @address.save
      redirect_to customers_addresses_path, notice: "Address added successfully"
    else
      render :new
    end
  end

  def edit; end

  def update
    if @address.update(address_params)
      redirect_to customers_addresses_path, notice: "Address updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @address.destroy
    redirect_to customers_addresses_path, notice: "Address deleted"
  end

  def make_default
    @address.update(default: true)
    redirect_to customers_addresses_path, notice: "Default address updated"
  end

  private

  def set_address
    @address = current_customer.addresses.find(params[:id])
  end

  def address_params
    params.require(:address).permit(:full_address, :default)
  end
end
