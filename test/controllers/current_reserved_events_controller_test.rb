require "test_helper"

class CurrentReservedEventsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get current_reserved_events_show_url
    assert_response :success
  end
end
