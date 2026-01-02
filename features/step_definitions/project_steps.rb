# Project step definitions

Given('I am on the projects page') do
  visit ps3_projects_path
end

When('I click {string}') do |link_or_button|
  click_link_or_button link_or_button
end

When('I fill in {string} with {string}') do |field, value|
  fill_in field, with: value
end

Then('I should see {string}') do |text|
  expect(page).to have_content(text)
end

Then('I should not see {string}') do |text|
  expect(page).not_to have_content(text)
end

Given('the following projects exist:') do |table|
  table.hashes.each do |row|
    Ps3Project.create!(name: row['name'], url: row['url'])
  end
end

When('I go to the projects page') do
  visit ps3_projects_path
end

Given('a project exists with name {string} and url {string}') do |name, url|
  @project = Ps3Project.create!(name: name, url: url)
end

Given('a project exists with name {string}') do |name|
  @project = Ps3Project.create!(name: name, url: 'https://example.com')
end

When('I go to the edit page for that project') do
  visit edit_ps3_project_path(@project)
end

When('I click {string} for {string}') do |action, name|
  project = Ps3Project.find_by(name: name)
  within("#ps3_project_#{project.id}") do
    click_link_or_button action
  end
end
