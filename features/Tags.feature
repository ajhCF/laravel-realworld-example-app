Feature: Tags
  As a user
  I want to browse available tags
  So that I can discover and filter articles by topic

  Scenario: Retrieve the list of tags
    Given articles exist with tags "laravel", "php", and "javascript"
    When I request the list of tags
    Then I should receive a 200 response
    And the response should contain the tags "laravel", "php", and "javascript"

  Scenario: Tags list is empty when no articles exist
    Given no articles exist in the system
    When I request the list of tags
    Then I should receive a 200 response
    And the response should contain an empty tags list

  Scenario: Tags list does not require authentication
    Given I am not logged in
    When I request the list of tags
    Then I should receive a 200 response

  Scenario: Tags are associated with articles on creation
    Given I am logged in as "johndoe"
    When I create an article with tags ["new-tag", "another-tag"]
    Then I should receive a 200 response
    And a subsequent request to the tags list should include "new-tag" and "another-tag"
