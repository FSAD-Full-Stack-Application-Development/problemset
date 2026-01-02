require "application_system_test_case"

class Ps3StudentsTest < ApplicationSystemTestCase
  setup do
    @ps3_student = ps3_students(:one)
  end

  test "visiting the index" do
    visit ps3_students_url
    assert_selector "h1", text: "Ps3 students"
  end

  test "should create ps3 student" do
    visit ps3_students_url
    click_on "New ps3 student"

    fill_in "Name", with: @ps3_student.name
    fill_in "Studentid", with: @ps3_student.studentid
    click_on "Create Ps3 student"

    assert_text "Ps3 student was successfully created"
    click_on "Back"
  end

  test "should update Ps3 student" do
    visit ps3_student_url(@ps3_student)
    click_on "Edit this ps3 student", match: :first

    fill_in "Name", with: @ps3_student.name
    fill_in "Studentid", with: @ps3_student.studentid
    click_on "Update Ps3 student"

    assert_text "Ps3 student was successfully updated"
    click_on "Back"
  end

  test "should destroy Ps3 student" do
    visit ps3_student_url(@ps3_student)
    click_on "Destroy this ps3 student", match: :first

    assert_text "Ps3 student was successfully destroyed"
  end
end
