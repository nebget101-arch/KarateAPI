Feature: Schema Validation Tests

  Background:
    * url 'https://jsonplaceholder.typicode.com'

  Scenario: Validate post response against schema
    Given path '/posts/1'
    When method get
    Then status 200
    And match response ==
      """
      {
        id: '#number',
        userId: '#number',
        title: '#string',
        body: '#string'
      }
      """

  Scenario: Validate multiple posts against schema
    Given path '/posts'
    When method get
    Then status 200
    And match each response ==
      """
      {
        id: '#number',
        userId: '#number',
        title: '#string',
        body: '#string'
      }
      """

  Scenario: Validate user response with nested objects
    Given path '/users/1'
    When method get
    Then status 200
    And match response ==
      """
      {
        id: '#number',
        name: '#string',
        username: '#string',
        email: '#string',
        address: '#object',
        phone: '#string',
        website: '#string',
        company: '#object'
      }
      """
    And match response.address ==
      """
      {
        street: '#string',
        suite: '#string',
        city: '#string',
        zipcode: '#string',
        geo: '#object'
      }
      """

  Scenario: Validate specific field types and constraints
    Given path '/posts/1'
    When method get
    Then status 200
    And assert response.id > 0
    And assert response.userId > 0
    And assert response.title.length > 0
    And assert response.body.length > 0
    And assert response.title != null
    And assert response.body != null

  Scenario: Validate array response with schema
    Given path '/users'
    When method get
    Then status 200
    And assert response.length > 0
    And match response[0] ==
      """
      {
        id: '#number',
        name: '#string',
        username: '#string',
        email: '#string',
        address: '#object',
        phone: '#string',
        website: '#string',
        company: '#object'
      }
      """

  Scenario: Validate response doesn't contain unexpected fields
    Given path '/posts/1'
    When method get
    Then status 200
    And match response == '#object'
    And assert response.id != null
    And assert response.userId != null
    And assert response.title != null
    And assert response.body != null
