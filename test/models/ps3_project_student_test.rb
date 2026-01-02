require "test_helper"

class Ps3ProjectStudentTest < ActiveSupport::TestCase
  def setup
    @project = ps3_projects(:one)
    @student = ps3_students(:alice)
    @project_student = Ps3ProjectStudent.new(ps3_project: @project, ps3_student: @student)
  end

  test "should be valid with valid attributes" do
    assert @project_student.valid?
  end

  test "should require ps3_project" do
    @project_student.ps3_project = nil
    assert_not @project_student.valid?
    assert_includes @project_student.errors[:ps3_project], "must exist"
  end

  test "should require ps3_student" do
    @project_student.ps3_student = nil
    assert_not @project_student.valid?
    assert_includes @project_student.errors[:ps3_student], "must exist"
  end

  test "should belong to ps3_project" do
    assert_respond_to @project_student, :ps3_project
  end

  test "should belong to ps3_student" do
    assert_respond_to @project_student, :ps3_student
  end

  test "should create association between project and student" do
    @project_student.save
    assert_includes @project.ps3_students, @student
    assert_includes @student.ps3_projects, @project
  end

  test "should allow multiple students per project" do
    @project_student.save
    second_student = ps3_students(:bob)
    second_association = Ps3ProjectStudent.create(ps3_project: @project, ps3_student: second_student)
    
    assert second_association.valid?
    # Count students currently associated with this project
    current_count = @project.reload.ps3_students.count
    assert current_count >= 2
  end

  test "should allow student to be in multiple projects" do
    @project_student.save
    second_project = ps3_projects(:two)
    second_association = Ps3ProjectStudent.create(ps3_project: second_project, ps3_student: @student)
    
    assert second_association.valid?
    # Count projects currently associated with this student
    current_count = @student.reload.ps3_projects.count
    assert current_count >= 2
  end
end
