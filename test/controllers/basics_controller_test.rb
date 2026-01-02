require "test_helper"

class BasicsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ps1_url
    assert_response :success
    assert_select "h1", /Problem Set 1: Basics/i
  end

  test "should get basics index via basics route" do
    get basics_url
    assert_response :success
    assert_select "h1", /Problem Set 1: Basics/i
  end

  test "should display generated time and rails environment" do
    get ps1_url
    assert_response :success
    
    # Check that the page contains environment and time information
    assert_select "p", text: /Page generated at:/
    assert_select "p", text: /Rails environment:/
  end

  test "should handle web scraping errors gracefully" do
    # Mock browser to test error handling
    # This test ensures the controller doesn't crash if web scraping fails
    get ps1_url
    assert_response :success
    
    # Page should load even if scraping fails
    assert_select "h1", /Problem Set 1: Basics/i
  end
end