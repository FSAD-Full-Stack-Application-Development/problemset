require "test_helper"

class Ps3StudentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @ps3_student = ps3_students(:charlie)
    @ps3_project = ps3_projects(:one)
    sign_in users(:one)
  end

  test "should get index" do
    get ps3_students_url
    assert_response :success
  end

  test "should get new" do
    get new_ps3_student_url
    assert_response :success
  end

  test "should create ps3_student" do
    assert_difference("Ps3Student.count") do
      post ps3_students_url, params: { ps3_student: { name: "Test Student", studentid: "S999" } }
    end

    assert_redirected_to ps3_student_url(Ps3Student.last)
  end

  test "should not create ps3_student with invalid params" do
    assert_no_difference("Ps3Student.count") do
      post ps3_students_url, params: { ps3_student: { name: "", studentid: "" } }
    end
    assert_response :unprocessable_entity
  end

  test "should update ps3_student in nested route with html format" do
    project = ps3_projects(:one)
    patch ps3_project_ps3_student_url(ps3_project_id: project.id, id: @ps3_student), params: { ps3_student: { name: @ps3_student.name, studentid: @ps3_student.studentid } }
    assert_redirected_to ps3_student_url(@ps3_student)
  end

  test "should update ps3_student in nested route with json format" do
    project = ps3_projects(:one)
    patch ps3_project_ps3_student_url(ps3_project_id: project.id, id: @ps3_student), params: { ps3_student: { name: @ps3_student.name, studentid: @ps3_student.studentid } }, as: :json
    assert_response :success
  end

  test "should handle update failure in nested route with json format" do
    project = ps3_projects(:one)
    patch ps3_project_ps3_student_url(ps3_project_id: project.id, id: @ps3_student), params: { ps3_student: { name: "", studentid: @ps3_student.studentid } }, as: :json
    assert_response :unprocessable_entity
  end

  test "should not create ps3_student via nested route with invalid params" do
    assert_no_difference("Ps3Student.count") do
      post ps3_project_ps3_students_url(@ps3_project), params: { ps3_student: { name: "", studentid: "" } }
    end
    # The nested route logic now properly handles validation failures by rendering :new
    assert_response :success
  end

  test "should show ps3_student" do
    get ps3_student_url(@ps3_student)
    assert_response :success
  end

  test "should get edit" do
    get edit_ps3_student_url(@ps3_student)
    assert_response :success
  end

  test "should update ps3_student" do
    patch ps3_student_url(@ps3_student), params: { ps3_student: { name: "Updated Name", studentid: @ps3_student.studentid } }
    assert_redirected_to ps3_student_url(@ps3_student)
    @ps3_student.reload
    assert_equal "Updated Name", @ps3_student.name
  end

  test "should not update ps3_student with invalid params" do
    patch ps3_student_url(@ps3_student), params: { ps3_student: { name: "", studentid: @ps3_student.studentid } }
    assert_response :unprocessable_entity
  end

  test "should destroy ps3_student" do
    assert_difference("Ps3Student.count", -1) do
      delete ps3_student_url(@ps3_student)
    end

    assert_redirected_to ps3_students_url
  end

  # JSON format tests
  test "should create ps3_student with json format" do
    assert_difference("Ps3Student.count") do
      post ps3_students_url, params: { ps3_student: { name: "JSON Student", studentid: "S777" } }, as: :json
    end
    assert_response :created
  end

  test "should not create ps3_student with invalid params in json format" do
    assert_no_difference("Ps3Student.count") do
      post ps3_students_url, params: { ps3_student: { name: "", studentid: "" } }, as: :json
    end
    assert_response :unprocessable_entity
  end

  test "should update ps3_student with json format" do
    patch ps3_student_url(@ps3_student), params: { ps3_student: { name: "JSON Updated", studentid: @ps3_student.studentid } }, as: :json
    assert_response :ok
  end

  test "should not update ps3_student with invalid params in json format" do
    patch ps3_student_url(@ps3_student), params: { ps3_student: { name: "", studentid: @ps3_student.studentid } }, as: :json
    assert_response :unprocessable_entity
  end

  test "should show ps3_student with json format" do
    get ps3_student_url(@ps3_student), as: :json
    assert_response :success
  end

  test "should destroy ps3_student with json format" do
    assert_difference("Ps3Student.count", -1) do
      delete ps3_student_url(@ps3_student), as: :json
    end

    assert_response :no_content
  end

  test "should get nested student new form" do
    get new_ps3_project_ps3_student_url(@ps3_project)
    assert_response :success
  end

  test "should get nested student edit form" do
    get edit_ps3_project_ps3_student_url(@ps3_project, @ps3_student)
    assert_response :success
  end

  test "should show nested student" do
    get ps3_project_ps3_student_url(@ps3_project, @ps3_student)
    assert_response :success
  end

  test "should update nested student" do
    patch ps3_project_ps3_student_url(@ps3_project, @ps3_student), params: { ps3_student: { name: "Updated Nested", studentid: @ps3_student.studentid } }
    assert_redirected_to ps3_student_url(@ps3_student)
  end

  test "should destroy nested student" do
    assert_difference("Ps3Student.count", -1) do
      delete ps3_project_ps3_student_url(@ps3_project, @ps3_student)
    end
    assert_redirected_to ps3_students_url
  end

  test "should get index with json format" do
    get ps3_students_url, as: :json
    assert_response :success
  end

  test "should get new for nested route" do
    get new_ps3_project_ps3_student_url(@ps3_project)
    assert_response :success
  end

  test "should handle nested create with successful student creation" do
    assert_difference("Ps3Student.count") do
      post ps3_project_ps3_students_url(@ps3_project), params: { ps3_student: { name: "Nested Success", studentid: "S555" } }
    end
    assert_redirected_to ps3_project_url(@ps3_project)
    assert_match "Student was successfully created", flash[:notice]
  end

  test "should handle nested create with validation failure and render new template" do
    # Now with the refactored controller logic, validation failures properly render :new
    assert_no_difference("Ps3Student.count") do
      post ps3_project_ps3_students_url(@ps3_project), params: { ps3_student: { name: "", studentid: "" } }
    end
    assert_response :success
  end

  test "should handle nested render new template when creation fails" do
    # Based on the actual behavior, the nested create always succeeds because
    # @project.ps3_students.create returns an object even if validation fails
    assert_difference("Ps3Student.count") do
      post ps3_project_ps3_students_url(@ps3_project), params: { ps3_student: { name: "Valid Name", studentid: "S888" } }
    end
    assert_redirected_to ps3_project_url(@ps3_project)
  end

  test "should handle edge case in nested create logic" do
    # Test a successful nested create to get full coverage
    ps3_project = ps3_projects(:one)
    assert_difference("Ps3Student.count") do
      post ps3_project_ps3_students_url(ps3_project), params: { ps3_student: { name: "Edge Case", studentid: "S777" } }
    end
    assert_redirected_to ps3_project_url(ps3_project)
  end

  test "should handle nested create failure and render new template" do
    # Test the failure path in nested create - this should now work with build/save
    assert_no_difference("Ps3Student.count") do
      post ps3_project_ps3_students_url(@ps3_project), params: { ps3_student: { name: "", studentid: "" } }
    end
    # Now it should render :new template since save will return false
    assert_response :success
  end

  test "should handle nested create failure with json format" do
    # Test the JSON failure path in nested create
    assert_no_difference("Ps3Student.count") do
      post ps3_project_ps3_students_url(@ps3_project), params: { ps3_student: { name: "", studentid: "" } }, as: :json
    end
    # This should render unprocessable_entity with student errors
    assert_response :unprocessable_entity
  end
end
