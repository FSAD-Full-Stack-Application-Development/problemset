# Step definitions for student.feature

Given('I am a teacher') do
  # Teacher is just a logged-in user in our system
  @user = create(:teacher)
end

Given('there is a project') do
  @project = create(:project)
end

Given('I want to add a student to the project') do
  # Build the student (not saved yet - will be created when added to project)
  @student = build(:student)
  # Save it now so it exists in the database for the dropdown
  @student.save!
end

Given('I am signed in') do
  visit '/users/sign_in'
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password
  click_button 'Log in'
end

When('I visit the projects page') do
  visit '/ps3/ps3_projects'
end

Then('I should see a link for the project') do
  expect(page).to have_link(@project.name, href: ps3_project_path(@project))
end

When('I click the link for the project') do
  find_link(@project.name, href: ps3_project_path(@project)).click
end

Then('I should see the details of my project') do
  # save_and_open_page  # Uncomment this to debug and see the actual page
  expect(page).to have_content(@project.name)
  expect(page).to have_content(@project.url)
end

Then('I should see a form to add a student') do
  # Check for the form fields to create a new student
  expect(page).to have_field('ps3_student[studentid]')
  expect(page).to have_field('ps3_student[name]')
end

When('I submit the form') do
  # Fill in the form fields and submit
  fill_in 'ps3_student[studentid]', with: @student.studentid
  fill_in 'ps3_student[name]', with: @student.name
  click_button 'Create Student'
end

Then('I should see the student added to the project') do
  expect(page).to have_content(@student.name)
end
