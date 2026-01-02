require "test_helper"

class Ps3StudentsHelperTest < ActionView::TestCase
  include Ps3StudentsHelper
  
  test "helper module can be included" do
    assert_kind_of Module, Ps3StudentsHelper
  end
end