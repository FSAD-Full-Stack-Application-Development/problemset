Feature: Manage Students
  As a teacher
  I want to manage students
  So that I can keep track of students working on projects

  Background:
    Given I am logged in as a user

  Scenario: Create a new student
    Given I am on the students page
    When I click "New Student"
    And I fill in "Studentid" with "ST12345"
    And I fill in "Name" with "John Doe"
    And I click "Create Student"
    Then I should see "Student was successfully created"
    And I should see "John Doe"

  Scenario: View list of students
    Given the following students exist:
      | studentid | name        |
      | ST001     | Yolanda Lim |
      | ST002     | Bob Johnson |
    When I go to the students page
    Then I should see "Alice Smith"
    And I should see "Bob Johnson"

  Scenario: Assign students to a project
    Given a project exists with name "Mobile App"
    And the following students exist:
      | studentid | name        |
      | ST001     | Yolanda Lim |
      | ST002     | Bob Johnson |
    When I assign "Alice Smith" to project "Mobile App"
    And I assign "Bob Johnson" to project "Mobile App"
    Then project "Mobile App" should have 2 students
