Feature: Articles
  As a user
  I want to create, read, update, and delete articles
  So that I can share and manage content on the platform

  Scenario: List all articles
    Given several articles exist in the system
    When I request the list of articles
    Then I should receive a 200 response
    And the response should contain a list of articles with their slugs, titles, and authors

  Scenario: List articles filtered by tag
    Given articles exist tagged with "laravel" and others with "javascript"
    When I request articles filtered by tag "laravel"
    Then I should receive a 200 response
    And all returned articles should be tagged with "laravel"

  Scenario: List articles filtered by author
    Given articles exist authored by "johndoe" and "janedoe"
    When I request articles filtered by author "johndoe"
    Then I should receive a 200 response
    And all returned articles should be authored by "johndoe"

  Scenario: List articles filtered by favorited user
    Given "janedoe" has favorited articles by "johndoe"
    When I request articles favorited by "janedoe"
    Then I should receive a 200 response
    And all returned articles should have been favorited by "janedoe"

  Scenario: List articles with limit and offset
    Given 20 articles exist in the system
    When I request articles with limit 5 and offset 10
    Then I should receive a 200 response
    And exactly 5 articles should be returned

  Scenario: Get a single article by slug
    Given an article exists with slug "my-test-article"
    When I request the article with slug "my-test-article"
    Then I should receive a 200 response
    And the response should include the article's title, body, and author

  Scenario: Get a non-existent article
    When I request the article with slug "does-not-exist"
    Then I should receive a 404 response

  Scenario: Create an article when authenticated
    Given I am logged in as "johndoe"
    When I create an article with title "My New Article", description "A description", body "Article body", and tags ["laravel", "php"]
    Then I should receive a 200 response
    And the response should include the article title "My New Article"
    And the slug should be derived from the title
    And the article should be tagged with "laravel" and "php"

  Scenario: Create an article without authentication
    Given I am not logged in
    When I attempt to create an article
    Then I should receive a 401 response

  Scenario: Create an article without a required title
    Given I am logged in as "johndoe"
    When I attempt to create an article without a title
    Then I should receive a 422 response
    And the response should contain a validation error for "title"

  Scenario: Update an article as the author
    Given I am logged in as "johndoe"
    And I have an article with slug "my-article"
    When I update the article "my-article" with title "Updated Title"
    Then I should receive a 200 response
    And the response should include the updated title "Updated Title"
    And the slug should be updated to match the new title

  Scenario: Update an article as a non-author
    Given I am logged in as "janedoe"
    And "johndoe" owns an article with slug "johndoe-article"
    When I attempt to update the article "johndoe-article"
    Then I should receive a 403 response

  Scenario: Delete an article as the author
    Given I am logged in as "johndoe"
    And I have an article with slug "my-article"
    When I delete the article "my-article"
    Then I should receive a 200 response
    And the article "my-article" should no longer exist

  Scenario: Delete an article as a non-author
    Given I am logged in as "janedoe"
    And "johndoe" owns an article with slug "johndoe-article"
    When I attempt to delete the article "johndoe-article"
    Then I should receive a 403 response
