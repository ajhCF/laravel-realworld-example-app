Feature: User Authentication
  As a registered user
  I want to log in and manage my session
  So that I can access protected resources

  Scenario: Successful login with valid credentials
    Given a user exists with email "john@example.com" and password "password123"
    When I submit a login request with email "john@example.com" and password "password123"
    Then I should receive a 200 response
    And the response should contain a JWT token
    And the response should include the user's email "john@example.com"

  Scenario: Login fails with incorrect password
    Given a user exists with email "john@example.com" and password "password123"
    When I submit a login request with email "john@example.com" and password "wrongpassword"
    Then I should receive a 403 response

  Scenario: Login fails with a non-existent email
    Given no user exists with email "ghost@example.com"
    When I submit a login request with email "ghost@example.com" and password "password123"
    Then I should receive a 403 response

  Scenario: Get current authenticated user
    Given I am logged in as "john@example.com"
    When I request the current user
    Then I should receive a 200 response
    And the response should include the user's email "john@example.com"
    And the response should contain a JWT token

  Scenario: Accessing current user without authentication
    Given I am not logged in
    When I request the current user
    Then I should receive a 401 response

  Scenario: Update current user profile
    Given I am logged in as "john@example.com"
    When I update my profile with bio "A software developer" and username "johndoe_updated"
    Then I should receive a 200 response
    And the response should include the updated bio "A software developer"

  Scenario: Update user email to one already taken
    Given I am logged in as "john@example.com"
    And another user exists with email "taken@example.com"
    When I update my profile with email "taken@example.com"
    Then I should receive a 422 response
    And the response should contain a validation error for "email"
