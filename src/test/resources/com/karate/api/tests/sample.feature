Feature: Sample API Tests

  Background:
    * url 'https://jsonplaceholder.typicode.com'

  Scenario: Get all posts
    Given path '/posts'
    When method get
    Then status 200
    And assert response.length > 0

  Scenario: Get a specific post
    Given path '/posts/1'
    When method get
    Then status 200
    And match response.id == 1
    And match response.userId == 1

  Scenario: Create a new post
    Given path '/posts'
    And request { title: 'Test Post', body: 'This is a test', userId: 1 }
    When method post
    Then status 201
    And match response.title == 'Test Post'

  Scenario: Update a post
    Given path '/posts/1'
    And request { title: 'Updated Post', body: 'Updated content', userId: 1, id: 1 }
    When method put
    Then status 200
    And match response.title == 'Updated Post'

  Scenario: Delete a post
    Given path '/posts/1'
    When method delete
    Then status 200
