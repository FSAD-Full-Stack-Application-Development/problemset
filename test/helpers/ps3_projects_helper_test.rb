require "test_helper"

class Ps3ProjectsHelperTest < ActionView::TestCase
  include Ps3ProjectsHelper
  
  test "helper module can be included" do
    assert_kind_of Module, Ps3ProjectsHelper
  end
end