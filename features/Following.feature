Feature: Following
  As an authenticated user
  I want to follow and unfollow other users
  So that I can curate my article feed

  Scenario: Follow another user
    Given I am logged in as "janedoe"
    And a user exists with username "johndoe"
    When I follow "johndoe"
    Then I should receive a 200 response
    And the response should include the profile for "johndoe"
    And the "following" field should be true

  Scenario: Unfollow a user I am following
    Given I am logged in as "janedoe"
    And I am following "johndoe"
    When I unfollow "johndoe"
    Then I should receive a 200 response
    And the response should include the profile for "johndoe"
    And the "following" field should be false

  Scenario: Follow a user without authentication
    Given I am not logged in
    When I attempt to follow "johndoe"
    Then I should receive a 401 response

  Scenario: Unfollow a user without authentication
    Given I am not logged in
    When I attempt to unfollow "johndoe"
    Then I should receive a 401 response

  Scenario: Follow a non-existent user
    Given I am logged in as "janedoe"
    When I follow "nonexistentuser"
    Then I should receive a 404 response

  Scenario: Articles from followed users appear in feed
    Given I am logged in as "janedoe"
    And "johndoe" has published an article "johndoe-article"
    When I follow "johndoe"
    And I request my article feed
    Then the feed should contain the article "johndoe-article"

  Scenario: Articles from unfollowed users no longer appear in feed
    Given I am logged in as "janedoe"
    And I am following "johndoe"
    And "johndoe" has published an article "johndoe-article"
    When I unfollow "johndoe"
    And I request my article feed
    Then the feed should not contain the article "johndoe-article"
