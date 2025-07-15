require "test_helper"

class Owner::DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get owner_dashboard_index_url
    assert_response :success
  end
end
