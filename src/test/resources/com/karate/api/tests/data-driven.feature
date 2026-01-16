Feature: Data-Driven Tests with JSON File

  Background:
    * url 'https://jsonplaceholder.typicode.com'

  Scenario: Read users from JSON file and validate structure
    * def users = read('classpath:data/users.json')
    * assert users.length == 3
    * match users[0].name == 'John Doe'
    * match users[1].email == 'jane.smith@example.com'
    * match users[2].role == 'user'

  Scenario Outline: Validate each user from JSON file
    * def users = read('classpath:data/users.json')
    * def user = users[<index>]
    * match user.id == <id>
    * match user.name == '<name>'
    * match user.email == '<email>'

    Examples:
      | index | id | name       | email                   |
      | 0     | 1  | John Doe   | john.doe@example.com    |
      | 1     | 2  | Jane Smith | jane.smith@example.com  |
      | 2     | 3  | Bob Johnson| bob.johnson@example.com |

  Scenario: Create user using data from JSON file
    * def users = read('classpath:data/users.json')
    * def newUser = users[0]
    Given path '/posts'
    And request { title: '#(newUser.name)', body: '#(newUser.email)', userId: '#(newUser.id)' }
    When method post
    Then status 201
    And match response.title == newUser.name
    And match response.body == newUser.email
