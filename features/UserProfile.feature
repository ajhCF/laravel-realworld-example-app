Feature: User Profile
  As a user
  I want to view other users' profiles
  So that I can learn about them and see their activity

  Scenario: View a public profile
    Given a user exists with username "johndoe"
    When I request the profile for "johndoe"
    Then I should receive a 200 response
    And the response should include the username "johndoe"
    And the response should include a "following" field

  Scenario: View profile of a followed user while authenticated
    Given I am logged in as "janedoe"
    And I am following "johndoe"
    When I request the profile for "johndoe"
    Then I should receive a 200 response
    And the "following" field should be true

  Scenario: View profile of an unfollowed user while authenticated
    Given I am logged in as "janedoe"
    And I am not following "johndoe"
    When I request the profile for "johndoe"
    Then I should receive a 200 response
    And the "following" field should be false

  Scenario: View profile of a non-existent user
    When I request the profile for "nobody"
    Then I should receive a 404 response
