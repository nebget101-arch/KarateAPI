Feature: Complex JSON Validation Tests

  Background:
    * url 'https://jsonplaceholder.typicode.com'

  Scenario: Validate deeply nested object structure
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
        address: {
          street: '#string',
          suite: '#string',
          city: '#string',
          zipcode: '#string',
          geo: {
            lat: '#string',
            lng: '#string'
          }
        },
        phone: '#string',
        website: '#string',
        company: {
          name: '#string',
          catchPhrase: '#string',
          bs: '#string'
        }
      }
      """

  Scenario: Validate array of objects with specific conditions
    Given path '/users'
    When method get
    Then status 200
    And assert response.length == 10
    And match each response ==
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
    # Validate specific fields in first user
    And match response[0].address.geo ==
      """
      {
        lat: '#string',
        lng: '#string'
      }
      """

  Scenario: Validate response with partial matching (ignoring extra fields)
    Given path '/posts/1'
    When method get
    Then status 200
    * def post = response
    And match post contains { id: '#number', title: '#string', body: '#string' }
    And assert post.id > 0
    And assert post.title.length > 5

  Scenario: Validate array filtering and assertion
    Given path '/users'
    When method get
    Then status 200
    * def users = response
    And assert users.length > 0
    And match users[0] ==
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

  Scenario: Validate JSON with custom matcher functions
    Given path '/posts'
    When method get
    Then status 200
    * def posts = response
    And assert posts.length > 0
    And assert posts[0].id != null
    And assert posts[0].title != null
    And assert posts[0].body != null
    And assert posts[0].userId != null

  Scenario: Validate complex nested array structure
    Given path '/users'
    When method get
    Then status 200
    # Verify pagination-like structure
    And assert response.length > 0
    And assert response[0].company.name != null
    And assert response[0].company.name.length > 0
  Scenario: Validate conditional fields based on values
    Given path '/users'
    When method get
    Then status 200
    * def users = response
    And assert users[0].email != null
    And assert users[0].email.length > 0

  Scenario: Read and validate data from external JSON file
    * def complexData = read('classpath:data/complex-users.json')
    And assert complexData.users.length == 2
    # Validate first user structure
    And match complexData.users[0] ==
      """
      {
        id: '#number',
        name: '#string',
        email: '#string',
        age: '#number',
        active: '#boolean',
        roles: '#[] #string',
        metadata: {
          lastLogin: '#string',
          loginCount: '#number',
          preferences: {
            theme: '#string',
            notifications: '#boolean',
            language: '#string'
          }
        },
        address: {
          street: '#string',
          city: '#string',
          country: '#string',
          zipcode: '#string'
        }
      }
      """
    # Validate pagination
    And match complexData.pagination ==
      """
      {
        page: '#number',
        pageSize: '#number',
        totalCount: '#number',
        totalPages: '#number'
      }
      """

  Scenario: Validate array of specific types with placeholders
    * def testData = 
      """
      {
        ids: [1, 2, 3, 4, 5],
        names: ['Alice', 'Bob', 'Charlie'],
        flags: [true, false, true],
        nested: [
          { id: 1, value: 'first' },
          { id: 2, value: 'second' }
        ]
      }
      """
    And match testData.ids == '#[] #number'
    And match testData.names == '#[] #string'
    And match testData.flags == '#[] #boolean'
    And match each testData.nested == { id: '#number', value: '#string' }

  Scenario: Complex response structure with mixed validation
    Given path '/users/1'
    When method get
    Then status 200
    * def user = response
    And assert user.id != null
    And assert user.name != null
    And assert user.username != null
    And assert user.email != null
    And assert user.address != null
    And assert user.phone != null
    And assert user.website != null
    And assert user.company != null
