Feature: Comments
  As a user
  I want to add and remove comments on articles
  So that I can engage in discussion around content

  Scenario: List comments on an article
    Given an article exists with slug "my-article"
    And the article has 2 comments
    When I request comments for the article "my-article"
    Then I should receive a 200 response
    And the response should contain 2 comments with their body and author

  Scenario: List comments on an article with no comments
    Given an article exists with slug "empty-article"
    And the article has no comments
    When I request comments for the article "empty-article"
    Then I should receive a 200 response
    And the response should contain an empty list of comments

  Scenario: Add a comment to an article when authenticated
    Given I am logged in as "janedoe"
    And an article exists with slug "my-article"
    When I post a comment with body "Great article!" on "my-article"
    Then I should receive a 200 response
    And the response should include the comment body "Great article!"
    And the comment author should be "janedoe"

  Scenario: Add a comment without authentication
    Given I am not logged in
    And an article exists with slug "my-article"
    When I attempt to post a comment on "my-article"
    Then I should receive a 401 response

  Scenario: Add a comment with an empty body
    Given I am logged in as "janedoe"
    And an article exists with slug "my-article"
    When I post a comment with an empty body on "my-article"
    Then I should receive a 422 response
    And the response should contain a validation error for "body"

  Scenario: Delete a comment as the comment author
    Given I am logged in as "janedoe"
    And "janedoe" has posted comment 42 on article "my-article"
    When I delete comment 42 from article "my-article"
    Then I should receive a 200 response
    And comment 42 should no longer exist on "my-article"

  Scenario: Delete a comment as a non-author
    Given I am logged in as "johndoe"
    And "janedoe" has posted comment 42 on article "my-article"
    When I attempt to delete comment 42 from article "my-article"
    Then I should receive a 403 response

  Scenario: Delete a comment without authentication
    Given I am not logged in
    When I attempt to delete a comment from an article
    Then I should receive a 401 response
