class PaymentMethodsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_store

  def index
    @payment_methods = @store.payment_methods
  end

  def new
    @payment_method = @store.payment_methods.build
  end

  def create
    @payment_method = @store.payment_methods.build(payment_method_params)
    if @payment_method.save
      redirect_to store_path(@store), notice: "Payment method added."
    else
      render :new
    end
  end

  private

  def set_store
    @store = current_user.stores.find(params[:store_id])
  end

  def payment_method_params
    params.require(:payment_method).permit(:name, :payment_type)
  end
end