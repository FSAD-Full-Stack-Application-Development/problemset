require "test_helper"

class Ps3AuthenticationTest < ActionDispatch::IntegrationTest
  test "should require authentication for creating ps3 project" do
    post ps3_projects_url, params: { ps3_project: { name: "Test", url: "http://test.com" } }
    assert_redirected_to new_user_session_path
  end

  test "should require authentication for creating ps3 student" do
    post ps3_students_url, params: { ps3_student: { name: "Test", studentid: "S123" } }
    assert_redirected_to new_user_session_path
  end

  test "should allow show actions without authentication for ps3 projects" do
    project = ps3_projects(:one)
    get ps3_project_url(project)
    assert_response :success
  end

  test "should allow show actions without authentication for ps3 students" do
    student = ps3_students(:alice)
    get ps3_student_url(student)
    assert_response :success
  end

  test "should require authentication for editing ps3 project" do
    project = ps3_projects(:one)
    get edit_ps3_project_url(project)
    assert_redirected_to new_user_session_path
  end

  test "should require authentication for editing ps3 student" do
    student = ps3_students(:alice)
    get edit_ps3_student_url(student)
    assert_redirected_to new_user_session_path
  end
end