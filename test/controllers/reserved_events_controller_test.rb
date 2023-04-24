require "test_helper"

class ReservedEventsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get reserved_events_index_url
    assert_response :success
  end

  test "should get show" do
    get reserved_events_show_url
    assert_response :success
  end
end
