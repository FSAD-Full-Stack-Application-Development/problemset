Feature: Manage Projects
  As a teacher
  I want to manage student projects
  So that I can track term projects for groups of students

  Background:
    Given I am logged in as a user

  Scenario: Create a new project
    Given I am on the projects page
    When I click "New ps3 project"
    And I fill in "Name" with "AI Chatbot"
    And I fill in "Url" with "https://github.com/team/ai-chatbot"
    And I click "Create Ps3 project"
    Then I should see "Ps3 project was successfully created"
    And I should see "AI Chatbot"

  Scenario: View list of projects
    Given the following projects exist:
      | name          | url                                |
      | Web Scraper   | https://github.com/team/scraper    |
      | Mobile App    | https://github.com/team/mobile     |
    When I go to the projects page
    Then I should see "Web Scraper"
    And I should see "Mobile App"

  Scenario: Edit a project
    Given a project exists with name "Old Name" and url "https://old.url"
    When I go to the edit page for that project
    And I fill in "Name" with "New Name"
    And I click "Update Ps3 project"
    Then I should see "Ps3 project was successfully updated"
    And I should see "New Name"

  Scenario: Delete a project
    Given a project exists with name "Deprecated Project"
    When I go to the projects page
    And I click "Delete" for "Deprecated Project"
    Then I should not see "Deprecated Project"
