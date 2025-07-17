class Dispatcher::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_dispatcher!

  def index
  @store = current_user.store_users.find_by(role: "dispatcher")&.store

  if @store
    @order_items = OrderItem
      .includes(order: :customer, product: :store)
      .where(products: { store_id: @store.id })
      .references(:products)
  else
    @order_items = []
  end
end

  def export
  @store = current_user.store_users.find_by(role: "dispatcher")&.store

  if @store
    @order_items = OrderItem
      .includes(order: :customer, product: :store)
      .where(products: { store_id: @store.id })
      .references(:products)
  else
    @order_items = []
  end

  respond_to do |format|
    format.csv do
      headers["Content-Disposition"] = "attachment; filename=\"orders-#{Date.today}.csv\""
      headers["Content-Type"] ||= "text/csv"
      render csv: generate_csv(@order_items)
    end
  end
end

  private

  def authorize_dispatcher!
    redirect_to root_path, alert: "Not authorized" unless current_user.dispatcher?
  end

  def generate_csv(order_items)
    CSV.generate(headers: true) do |csv|
      csv << ["Order ID", "Customer Email", "Product Name", "Quantity", "Store", "Order Date"]
      order_items.each do |item|
        csv << [
          item.order.id,
          item.order.customer.email,
          item.product.name,
          item.quantity,
          item.product.store.name,
          item.order.created_at.to_date
        ]
      end
    end
  end
end
