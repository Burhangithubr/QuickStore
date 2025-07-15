class ProductsController < ApplicationController
    before_action :set_store
    before_action :set_product, only: [:edit,:update,:destroy]
    def index
       @store = current_user.stores.find(params[:store_id])
        @products =@store.products
    end
    def edit
    end

    def new
       @store = Store.find(params[:store_id])
  @product = @store.products.build
    end
    def update
        if @product.update(product_params)
            redirect_to store_products_path(@store),notice: "product updated successfully"
        else
            render :edit
        end
    end
    def create
        @product=@store.products.build(product_params)
        if @product.save
            redirect_to store_products_path(@store), notice: "Product Added successfully"

        else
            render :new
        end

    end
    def destroy
        @product.destroy
        redirect_to store_products_path(@store), notice: "product deleted"

    end
    private
    def set_store
        @store = current_user.stores.find(params[:store_id])
    end
    def set_product
        @product=@store.products.find(params[:id])
    end
    def product_params
        params.require(:product).permit(:name,:description,:price,:stock,:image)
    end


end
