require "test_helper"

class Dispatcher::DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dispatcher_dashboard_index_url
    assert_response :success
  end
end
