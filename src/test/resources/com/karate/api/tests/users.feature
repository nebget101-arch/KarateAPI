Feature: User API Tests

  Background:
    * url 'https://jsonplaceholder.typicode.com'

  Scenario: Get all users
    Given path '/users'
    When method get
    Then status 200
    And assert response.length == 10

  Scenario: Get user by id
    Given path '/users/1'
    When method get
    Then status 200
    And match response.name == 'Leanne Graham'
    And match response.email == 'Sincere@april.biz'

  Scenario: Validate user structure
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
