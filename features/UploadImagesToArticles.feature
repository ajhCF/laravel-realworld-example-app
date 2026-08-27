Feature: Upload Images to Articles
  As a user
  I need to be able to upload images against an article for other users to view
  So that I can enhance the article with visual content

  Scenario: Upload an image to an article
    Given I am logged in as "johndoe"
    And an article exists with slug "my-article"
    When I upload an image to the article "my-article"
    Then I should receive a 200 response
    And the article should have the uploaded image

  Scenario: Upload multiple images to an article
    Given I am logged in as "johndoe"
    And an article exists with slug "my-article"
    When I upload three images to the article "my-article"
    Then I should receive a 200 response
    And the article should have all three images

  Scenario: Attempt to upload more than three images to an article
    Given I am logged in as "johndoe"
    And an article exists with slug "my-article"
    When I attempt to upload four images to the article "my-article"
    Then I should receive a 422 response
    And the response should contain a validation error indicating the maximum number of images has been exceeded

  Scenario: Attempt to upload an image to an article without authentication
    Given I am not logged in
    And an article exists with slug "my-article"
    When I attempt to upload an image to the article "my-article"
    Then I should receive a 401 response

  Scenario: Attempt to delete an image from an article as the uploader
    Given I am logged in as "johndoe"
    And an article exists with slug "my-article" and has an image uploaded by "johndoe"
    When I delete the image from the article "my-article"
    Then I should receive a 200 response
    And the article should no longer have the deleted image

  Scenario: Attempt to delete an image from an article as a non-uploader
    Given I am logged in as "janedoe"
    And an article exists with slug "my-article" and has an image uploaded by "johndoe"
    When I attempt to delete the image from the article "my-article"
    Then I should receive a 403 response