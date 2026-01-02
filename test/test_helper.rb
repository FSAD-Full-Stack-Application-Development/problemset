require 'simplecov'
SimpleCov.start 'rails' do
  add_filter 'app/channels'
  add_filter 'app/jobs'
  # Exclude PS1 (basics/news) functionality
  add_filter 'app/controllers/basics_controller.rb'
  add_filter 'app/controllers/main_controller.rb'
  # Exclude PS2 (jokes) functionality  
  add_filter 'app/controllers/jokes_controller.rb'
  add_filter 'app/models/joke.rb'
  # Exclude base classes that don't need testing
  add_filter 'app/controllers/application_controller.rb'
  add_filter 'app/models/application_record.rb'
end

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  fixtures :all
end
