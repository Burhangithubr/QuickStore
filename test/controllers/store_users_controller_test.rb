require "test_helper"

class StoreUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get store_users_new_url
    assert_response :success
  end

  test "should get create" do
    get store_users_create_url
    assert_response :success
  end

  test "should get index" do
    get store_users_index_url
    assert_response :success
  end
end
