Feature: Article Favorites
  As an authenticated user
  I want to favorite and unfavorite articles
  So that I can bookmark content I enjoy

  Scenario: Favorite an article
    Given I am logged in as "janedoe"
    And an article exists with slug "great-article"
    When I favorite the article "great-article"
    Then I should receive a 200 response
    And the article's favorites count should be incremented
    And the response should indicate the article is favorited

  Scenario: Unfavorite a previously favorited article
    Given I am logged in as "janedoe"
    And I have favorited the article "great-article"
    When I unfavorite the article "great-article"
    Then I should receive a 200 response
    And the article's favorites count should be decremented
    And the response should indicate the article is not favorited

  Scenario: Favorite an article without authentication
    Given I am not logged in
    And an article exists with slug "great-article"
    When I attempt to favorite the article "great-article"
    Then I should receive a 401 response

  Scenario: Unfavorite an article without authentication
    Given I am not logged in
    When I attempt to unfavorite the article "great-article"
    Then I should receive a 401 response

  Scenario: Favorited articles appear in filtered article list
    Given I am logged in as "janedoe"
    And I have favorited the article "great-article"
    When I request articles favorited by "janedoe"
    Then the response should include the article "great-article"
