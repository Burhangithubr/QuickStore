class OrderMailer < ApplicationMailer
  default from: 'no-reply@quickstore.com'

  def customer_order_confirmation(order)
    @order = order
    @customer = order.customer
    mail(to: @customer.email, subject: "Order ##{@order.id} Confirmation")
  end

    def store_owner_notification(order)
    @order = order
    @store_owner = @order.store.owner

    mail(
      to: @store_owner.email,
      subject: "New Order ##{@order.id} Received"
    )
  end
end
