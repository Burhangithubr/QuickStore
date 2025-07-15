require "test_helper"

class StockManager::DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get stock_manager_dashboard_index_url
    assert_response :success
  end
end
