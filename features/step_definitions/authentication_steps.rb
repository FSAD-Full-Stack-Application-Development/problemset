# Authentication step definitions

Given('I am logged in as a user') do
  @user = User.create!(
    email: 'test@example.com',
    password: 'password123',
    password_confirmation: 'password123'
  )
  visit new_user_session_path
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: 'password123'
  click_button 'Log in'
end

Given('I am not logged in') do
  # Just ensure we're not logged in (skip logout if not needed)
  # No action needed - tests start with no session
end

Given('a user exists with email {string} and password {string}') do |email, password|
  User.create!(
    email: email,
    password: password,
    password_confirmation: password
  )
end

Given('I am on the sign up page') do
  visit new_user_registration_path
end

Given('I am on the login page') do
  visit new_user_session_path
end

When('I try to visit the projects page') do
  visit ps3_projects_path
end

When('I try to visit the students page') do
  visit ps3_students_path
end

Then('I should be redirected to the login page') do
  expect(current_path).to eq(new_user_session_path)
end
