require "test_helper"

class MainControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url
    assert_response :success
    assert_select "h1", /Problem Sets/i
    assert_select "a[href=?]", ps1_path
    assert_select "a[href=?]", ps2_path
    assert_select "a[href=?]", ps3_path
  end

  test "should display all problem sets" do
    get root_url
    assert_response :success
    
    # Check that all three problem sets are displayed
    assert_select "a", text: /Problem Set 1/
    assert_select "a", text: /Problem Set 2/
    assert_select "a", text: /Problem Set 3/
  end
end