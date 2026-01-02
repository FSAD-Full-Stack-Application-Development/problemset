Feature: User Authentication for Project Tracker
  As a system administrator
  I want to restrict access to the project tracker
  So that only authenticated teachers can manage projects

  Scenario: Unauthenticated user cannot access projects
    Given I am not logged in
    When I try to visit the projects page
    Then I should be redirected to the login page
    And I should see "You need to sign in or sign up before continuing"

  Scenario: Unauthenticated user cannot access students
    Given I am not logged in
    When I try to visit the students page
    Then I should be redirected to the login page

  Scenario: User can sign up
    Given I am on the sign up page
    When I fill in "Email" with "teacher@example.com"
    And I fill in "Password" with "password123"
    And I fill in "Password confirmation" with "password123"
    And I click "Sign up"
    Then I should see "Welcome! You have signed up successfully"

  Scenario: User can log in
    Given a user exists with email "teacher@example.com" and password "password123"
    And I am on the login page
    When I fill in "Email" with "teacher@example.com"
    And I fill in "Password" with "password123"
    And I click "Log in"
    Then I should see "Signed in successfully"

  Scenario: User can log out
    Given I am logged in as a user
    When I click "Log out"
    Then I should see "Signed out successfully"
