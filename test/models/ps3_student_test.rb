require "test_helper"

class Ps3StudentTest < ActiveSupport::TestCase
  def setup
    @student = Ps3Student.new(name: "Test Student", studentid: "S999")
  end

  test "should be valid with valid attributes" do
    assert @student.valid?
  end

  test "should validate presence of studentid" do
    student = Ps3Student.new(name: "Test")
    assert_not student.valid?
    assert_includes student.errors[:studentid], "can't be blank"
  end

  test "should validate presence of name" do
    student = Ps3Student.new(studentid: "S123")
    assert_not student.valid?
    assert_includes student.errors[:name], "can't be blank"
  end

  test "should validate uniqueness of name" do
    existing = ps3_students(:alice)
    student = Ps3Student.new(name: existing.name, studentid: "S999")
    assert_not student.valid?
    assert_includes student.errors[:name], "has already been taken"
  end

  test "should allow same name after deletion" do
    @student.save
    original_name = @student.name
    @student.destroy
    new_student = Ps3Student.new(name: original_name, studentid: "S888")
    assert new_student.valid?
  end

  test "should have many ps3_project_students" do
    assert_respond_to @student, :ps3_project_students
  end

  test "should have many ps3_projects through ps3_project_students" do
    assert_respond_to @student, :ps3_projects
  end

  test "should be able to join projects" do
    @student.save
    project = ps3_projects(:one)
    @student.ps3_projects << project
    assert_includes @student.ps3_projects, project
  end

  test "should allow duplicate studentid" do
    @student.save
    duplicate_student = Ps3Student.new(name: "Different Name", studentid: @student.studentid)
    assert duplicate_student.valid?
  end
end