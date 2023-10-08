require "test_helper"

class Public::HotSpringsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_hot_springs_index_url
    assert_response :success
  end

  test "should get show" do
    get public_hot_springs_show_url
    assert_response :success
  end
end
