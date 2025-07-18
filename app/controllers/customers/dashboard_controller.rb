class Customers::DashboardController < ApplicationController
  before_action :authenticate_customer!

  def index
    @stores = Store.all
  end
end

