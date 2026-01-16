Feature: API Authentication Methods

  Background:
    * url baseUrl

  Scenario: Basic Authentication
    Given path '/basic-auth'
    And header Authorization = 'Basic ' + karate.encode('user:password')
    When method get
    Then status 200
    And match response == { authenticated: true, user: 'user' }

  Scenario: Bearer Token Authentication
    * def token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9' // example token
    Given path '/bearer-auth'
    And header Authorization = 'Bearer ' + token
    When method get
    Then status 200
    And match response == { authenticated: true, token: '#string' }

  Scenario: API Key in Header
    Given path '/api-key-auth'
    And header X-API-KEY = 'my-api-key-123'
    When method get
    Then status 200
    And match response == { success: true }

  Scenario: API Key in Query Param
    Given path '/api-key-auth'
    And param api_key = 'my-api-key-123'
    When method get
    Then status 200
    And match response == { success: true }

  Scenario: OAuth2 Access Token
    * def accessToken = 'ya29.a0AfH6SMB...' // example token
    Given path '/oauth2-protected'
    And header Authorization = 'Bearer ' + accessToken
    When method get
    Then status 200
    And match response == { authorized: true }
