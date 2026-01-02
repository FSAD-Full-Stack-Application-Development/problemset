# Student step definitions

Given('I am on the students page') do
  visit ps3_students_path
end

Given('the following students exist:') do |table|
  table.hashes.each do |row|
    Ps3Student.create!(studentid: row['studentid'], name: row['name'])
  end
end

When('I go to the students page') do
  visit ps3_students_path
end

When('I assign {string} to project {string}') do |student_name, project_name|
  student = Ps3Student.find_by(name: student_name)
  project = Ps3Project.find_by(name: project_name)
  Ps3ProjectStudent.create!(ps3_student: student, ps3_project: project)
end

Then('project {string} should have {int} students') do |project_name, count|
  project = Ps3Project.find_by(name: project_name)
  expect(project.ps3_students.count).to eq(count)
end
