require "application_system_test_case"

class Ps3ProjectsTest < ApplicationSystemTestCase
  setup do
    @ps3_project = ps3_projects(:one)
  end

  test "visiting the index" do
    visit ps3_projects_url
    assert_selector "h1", text: "Ps3 projects"
  end

  test "should create ps3 project" do
    visit ps3_projects_url
    click_on "New ps3 project"

    fill_in "Name", with: @ps3_project.name
    fill_in "Url", with: @ps3_project.url
    click_on "Create Ps3 project"

    assert_text "Ps3 project was successfully created"
    click_on "Back"
  end

  test "should update Ps3 project" do
    visit ps3_project_url(@ps3_project)
    click_on "Edit this ps3 project", match: :first

    fill_in "Name", with: @ps3_project.name
    fill_in "Url", with: @ps3_project.url
    click_on "Update Ps3 project"

    assert_text "Ps3 project was successfully updated"
    click_on "Back"
  end

  test "should destroy Ps3 project" do
    visit ps3_project_url(@ps3_project)
    click_on "Destroy this ps3 project", match: :first

    assert_text "Ps3 project was successfully destroyed"
  end
end
