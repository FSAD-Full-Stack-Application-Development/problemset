require "test_helper"

class Ps3ProjectTest < ActiveSupport::TestCase
  def setup
    @project = Ps3Project.new(name: "Test Project", url: "http://test.com")
  end

  test "should be valid with valid attributes" do
    assert @project.valid?
  end

  test "should validate presence of name" do
    project = Ps3Project.new
    assert_not project.valid?
    assert_includes project.errors[:name], "can't be blank"
  end

  test "should validate uniqueness of name" do
    existing = ps3_projects(:one)
    project = Ps3Project.new(name: existing.name)
    assert_not project.valid?
    assert_includes project.errors[:name], "has already been taken"
  end

  test "should allow same name after deletion" do
    @project.save
    original_name = @project.name
    @project.destroy
    new_project = Ps3Project.new(name: original_name, url: "http://new.com")
    assert new_project.valid?
  end

  test "should have many ps3_project_students" do
    assert_respond_to @project, :ps3_project_students
  end

  test "should have many ps3_students through ps3_project_students" do
    assert_respond_to @project, :ps3_students
  end

  test "should be able to add students" do
    @project.save
    student = ps3_students(:alice)
    @project.ps3_students << student
    assert_includes @project.ps3_students, student
  end

  test "should allow url to be blank" do
    @project.url = nil
    assert @project.valid?
    
    @project.url = ""
    assert @project.valid?
  end
end