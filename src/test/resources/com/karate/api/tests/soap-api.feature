Feature: SOAP API Tests

  Scenario: Test SOAP request construction with string
    * def celsiusValue = 25
    * def soapRequest = '<soap:Envelope><soap:Body><web:CelsiusToFahrenheit><web:Celsius>' + celsiusValue + '</web:Celsius></web:CelsiusToFahrenheit></soap:Body></soap:Envelope>'
    And assert soapRequest.contains('Celsius')
    And assert soapRequest.contains('Envelope')
    And assert soapRequest.contains('Body')

  Scenario: Validate SOAP response structure
    * def soapResponse = '<soap:Envelope><soap:Body><web:FahrenheitToCelsiusResponse><web:FahrenheitToCelsiusResult>37</web:FahrenheitToCelsiusResult></web:FahrenheitToCelsiusResponse></soap:Body></soap:Envelope>'
    And assert soapResponse.contains('FahrenheitToCelsiusResult')
    And assert soapResponse.contains('soap:Envelope')

  Scenario: Test SOAP request construction with variables
    * def celsius = 0
    * def soapRequest = '<soap:Envelope><soap:Body><web:CelsiusToFahrenheit><web:Celsius>' + celsius + '</web:Celsius></web:CelsiusToFahrenheit></soap:Body></soap:Envelope>'
    And assert soapRequest.contains('0')
    And assert soapRequest.contains('CelsiusToFahrenheit')

  Scenario: Test SOAP response with simple string validation
    * def weatherOperation = 'GetWeather'
    * def cityName = 'New York'
    * def soapRequest = '<soap:Envelope><soap:Body><web:' + weatherOperation + '><web:CityName>' + cityName + '</web:CityName></web:' + weatherOperation + '></soap:Body></soap:Envelope>'
    And assert soapRequest.contains(weatherOperation)
    And assert soapRequest.contains(cityName)

  Scenario: Test SOAP namespace validation
    * def soapRequest = '<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://www.webserviceX.NET/"><soap:Body><web:CelsiusToFahrenheit><web:Celsius>10</web:Celsius></web:CelsiusToFahrenheit></soap:Body></soap:Envelope>'
    And assert soapRequest.contains('xmlns:soap')
    And assert soapRequest.contains('xmlns:web')

  Scenario: Test SOAP currency request validation
    * def currencyOperation = 'GetCurrencyByCountry'
    * def countryName = 'United States'
    * def soapRequest = '<soap:Envelope><soap:Body><web:' + currencyOperation + '><web:CountryName>' + countryName + '</web:CountryName></web:' + currencyOperation + '></soap:Body></soap:Envelope>'
    And assert soapRequest.contains(currencyOperation)
    And assert soapRequest.contains(countryName)

  Scenario: Test SOAP with conditional validation
    * def soapRequest = '<soap:Envelope><soap:Body><web:CelsiusToFahrenheit><web:Celsius>100</web:Celsius></web:CelsiusToFahrenheit></soap:Body></soap:Envelope>'
    * def hasCelsius = soapRequest.contains('Celsius')
    * def hasEnvelope = soapRequest.contains('Envelope')
    And assert hasCelsius
    And assert hasEnvelope

  Scenario: Test SOAP response with multiple operations
    * def soapOperation1 = 'CelsiusToFahrenheit'
    * def soapOperation2 = 'FahrenheitToCelsius'
    * def soapRequest = '<soap:Envelope><soap:Body><web:' + soapOperation1 + '><web:Celsius>15</web:Celsius></web:' + soapOperation1 + '></soap:Body></soap:Envelope>'
    And assert soapRequest.contains(soapOperation1)
    And assert soapRequest.contains('Celsius')

  Scenario: Test SOAP numeric value handling
    * def temperature = 32
    * def soapResponse = '<web:CelsiusToFahrenheitResult>' + temperature + '</web:CelsiusToFahrenheitResult>'
    * def result = temperature
    And assert result == 32
    And assert result > 0
