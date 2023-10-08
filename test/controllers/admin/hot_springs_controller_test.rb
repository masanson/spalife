require "test_helper"

class Admin::HotSpringsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_hot_springs_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_hot_springs_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_hot_springs_edit_url
    assert_response :success
  end
end
