require "test_helper"

class Ps3ProjectsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @ps3_project = ps3_projects(:one)
    @ps3_student = ps3_students(:alice)
    sign_in users(:one)
  end

  test "should get index" do
    get ps3_projects_url
    assert_response :success
  end

  test "should get new" do
    get new_ps3_project_url
    assert_response :success
  end

  test "should create ps3_project" do
    assert_difference('Ps3Project.count', 1) do
      post ps3_projects_url, params: { ps3_project: { name: "New Project", url: "http://example.com" } }
    end
    assert_redirected_to ps3_project_url(Ps3Project.last)
  end

  test "should not create ps3_project with invalid params" do
    assert_no_difference('Ps3Project.count') do
      post ps3_projects_url, params: { ps3_project: { name: "", url: "" } }
    end
    assert_response :unprocessable_entity
  end

  test "should show ps3_project" do
    get ps3_project_url(@ps3_project)
    assert_response :success
  end

  test "should get edit" do
    get edit_ps3_project_url(@ps3_project)
    assert_response :success
  end

  test "should update ps3_project" do
    patch ps3_project_url(@ps3_project), params: { ps3_project: { name: "Updated Name", url: @ps3_project.url } }
    assert_redirected_to ps3_project_url(@ps3_project)
    @ps3_project.reload
    assert_equal "Updated Name", @ps3_project.name
  end

  test "should not update ps3_project with invalid params" do
    patch ps3_project_url(@ps3_project), params: { ps3_project: { name: "", url: @ps3_project.url } }
    assert_response :unprocessable_entity
  end

  test "should destroy ps3_project" do
    # First, delete all join records
    @ps3_project.ps3_project_students.destroy_all

    assert_difference('Ps3Project.count', -1) do
      delete ps3_project_url(@ps3_project)
    end

    assert_redirected_to ps3_projects_url
  end

  test "should add student to project" do
    # Ensure student is not already on project
    @ps3_project.ps3_students.delete(@ps3_student)
    
    assert_difference('@ps3_project.ps3_students.count', 1) do
      post add_student_ps3_project_url(@ps3_project), params: { student_id: @ps3_student.id }
    end
    
    assert_redirected_to ps3_project_url(@ps3_project)
    assert_match "was successfully added", flash[:notice]
  end

  test "should not add student to project if already assigned" do
    # Ensure student is already on project
    @ps3_project.ps3_students << @ps3_student unless @ps3_project.ps3_students.include?(@ps3_student)
    
    assert_no_difference('@ps3_project.ps3_students.count') do
      post add_student_ps3_project_url(@ps3_project), params: { student_id: @ps3_student.id }
    end
    
    assert_redirected_to ps3_project_url(@ps3_project)
    assert_match "is already on this project", flash[:alert]
  end

  # JSON format tests
  test "should create ps3_project with json format" do
    assert_difference('Ps3Project.count', 1) do
      post ps3_projects_url, params: { ps3_project: { name: "JSON Project", url: "http://json.com" } }, as: :json
    end
    assert_response :created
  end

  test "should not create ps3_project with invalid params in json format" do
    assert_no_difference('Ps3Project.count') do
      post ps3_projects_url, params: { ps3_project: { name: "", url: "" } }, as: :json
    end
    assert_response :unprocessable_entity
  end

  test "should update ps3_project with json format" do
    patch ps3_project_url(@ps3_project), params: { ps3_project: { name: "JSON Updated", url: @ps3_project.url } }, as: :json
    assert_response :ok
  end

  test "should not update ps3_project with invalid params in json format" do
    patch ps3_project_url(@ps3_project), params: { ps3_project: { name: "", url: @ps3_project.url } }, as: :json
    assert_response :unprocessable_entity
  end

  test "should show ps3_project with json format" do
    get ps3_project_url(@ps3_project), as: :json
    assert_response :success
  end

  test "should destroy ps3_project with json format" do
    # First, delete all join records
    @ps3_project.ps3_project_students.destroy_all

    assert_difference('Ps3Project.count', -1) do
      delete ps3_project_url(@ps3_project), as: :json
    end

    assert_response :no_content
  end

  test "should handle ps3 index route" do
    get ps3_url
    assert_response :success
  end

  test "should get index with json format" do
    get ps3_projects_url, as: :json
    assert_response :success
  end

  test "should handle create failure with json format" do
    assert_no_difference('Ps3Project.count') do
      post ps3_projects_url, params: { ps3_project: { name: "" } }, as: :json
    end
    assert_response :unprocessable_entity
  end

  test "should handle update failure with json format" do
    patch ps3_project_url(@ps3_project), params: { ps3_project: { name: "" } }, as: :json
    assert_response :unprocessable_entity
  end
end
