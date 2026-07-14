Feature: Article Feed
  As an authenticated user
  I want to see a personalised feed of articles
  So that I can read content from authors I follow

  Scenario: View feed of articles from followed authors
    Given I am logged in as "janedoe"
    And I am following "johndoe"
    And "johndoe" has published 3 articles
    When I request my article feed
    Then I should receive a 200 response
    And the feed should contain articles authored by "johndoe"

  Scenario: Feed is empty when not following anyone
    Given I am logged in as "janedoe"
    And I am not following any users
    When I request my article feed
    Then I should receive a 200 response
    And the feed should be empty

  Scenario: Feed does not include articles from non-followed authors
    Given I am logged in as "janedoe"
    And I am not following "otherperson"
    And "otherperson" has published articles
    When I request my article feed
    Then the feed should not contain articles authored by "otherperson"

  Scenario: View feed with limit and offset
    Given I am logged in as "janedoe"
    And I am following "johndoe"
    And "johndoe" has published 10 articles
    When I request my article feed with limit 3 and offset 2
    Then I should receive a 200 response
    And exactly 3 articles should be returned

  Scenario: Accessing feed without authentication
    Given I am not logged in
    When I request the article feed
    Then I should receive a 401 response
