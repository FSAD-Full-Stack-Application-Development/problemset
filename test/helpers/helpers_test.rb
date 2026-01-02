require "test_helper"

class HelpersTest < ActiveSupport::TestCase
  test "helpers should be defined" do
    assert defined?(ApplicationHelper)
    assert defined?(ProjectsHelper)
    assert defined?(Ps3ProjectsHelper)
    assert defined?(Ps3StudentsHelper)
  end
  
  test "application mailer should be defined" do
    assert defined?(ApplicationMailer)
    assert_equal "from@example.com", ApplicationMailer.default[:from]
  end
end
