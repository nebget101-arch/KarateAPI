# Karate API Test Project

A comprehensive API testing framework using Karate.

## Project Structure

```
src/test/
├── java/
│   └── com/karate/api/tests/
│       └── KarateTests.java      # Main test runner
└── resources/
    ├── com/karate/api/tests/
    │   ├── sample.feature        # Sample API tests
    │   ├── users.feature         # User API tests
    │   └── authentication.feature # Authentication method tests
    └── karate-config.js          # Configuration file
```

## Getting Started

### Prerequisites
- Java 11 or higher
- Maven 3.6+

### Installation

1. Clone or navigate to the project directory:
```bash
cd /Users/nebyougetaneh/Desktop/KarateAPI
```

2. Run tests:
```bash
mvn clean test
```

### Running Specific Tests

Run a single feature file:
```bash
mvn test -Dkarate.options="classpath:com/karate/api/tests/sample.feature"
```

Run tests for a specific scenario:
```bash
mvn test -Dkarate.options="classpath:com/karate/api/tests/users.feature -t @YourTag"
```

### Running Tests by Environment

```bash
mvn test -Dkarate.env=dev
mvn test -Dkarate.env=prod
```

## Writing Tests

### Basic Test Structure

```gherkin
Feature: Feature Name

  Background:
    * url 'https://api.example.com'

  Scenario: Scenario Description
    Given path '/endpoint'
    And header Authorization = 'Bearer token'
    When method get
    Then status 200
    And match response.id == 1
```

### Common Karate Functions

- `Given path` - Set the request path
- `And header` - Add HTTP headers
- `And request` - Set request body
- `When method` - Specify HTTP method
- `Then status` - Assert response status code
- `And match` - Assert response content
- `And assert` - Evaluate expressions

## Example Feature Files

### sample.feature
Tests basic CRUD operations on a JSON API


### users.feature
Tests user endpoint with response validation

### authentication.feature
Tests different API authentication methods: Basic Auth, Bearer Token, API Key (header/query), and OAuth2.

## Further Reading

- [Karate Documentation](https://karatelabs.github.io/karate/)
- [Karate GitHub Repository](https://github.com/intuit/karate)
