Feature: User Registration
  As a visitor
  I want to register for an account
  So that I can access authenticated features of the application

  Scenario: Successful registration with valid details
    Given I am not logged in
    When I submit a registration request with username "johndoe", email "john@example.com", and password "password123"
    Then I should receive a 200 response
    And the response should contain a JWT token
    And the response should include the username "johndoe" and email "john@example.com"

  Scenario: Registration fails with a duplicate email
    Given a user already exists with email "john@example.com"
    When I submit a registration request with username "janedoe", email "john@example.com", and password "password123"
    Then I should receive a 422 response
    And the response should contain a validation error for "email"

  Scenario: Registration fails with a duplicate username
    Given a user already exists with username "johndoe"
    When I submit a registration request with username "johndoe", email "new@example.com", and password "password123"
    Then I should receive a 422 response
    And the response should contain a validation error for "username"

  Scenario: Registration fails when required fields are missing
    Given I am not logged in
    When I submit a registration request with no email
    Then I should receive a 422 response
    And the response should contain a validation error for "email"

  Scenario: Registration fails with an invalid email format
    Given I am not logged in
    When I submit a registration request with username "johndoe", email "not-an-email", and password "password123"
    Then I should receive a 422 response
    And the response should contain a validation error for "email"
