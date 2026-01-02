require "test_helper"

class ApplicationIntegrationTest < ActionDispatch::IntegrationTest
  test "should redirect to main page from root" do
    get "/"
    assert_response :success
    assert_select "h1", /Problem Sets/
  end

  test "health check should work" do
    get rails_health_check_url
    assert_response :success
  end
end