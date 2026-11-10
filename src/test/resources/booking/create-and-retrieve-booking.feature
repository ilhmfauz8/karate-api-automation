@booking @create-and-retrieve-booking
Feature: Booking creation and retrieval

  Background:
    * url bookingBaseUrl
    * header Accept = 'application/json'

  Scenario: Create a booking and retrieve the same booking by its generated ID
    * def booking =
      """
      {
        firstname: 'Ilham',
        lastname: 'Fauzi',
        totalprice: 1234,
        depositpaid: true,
        bookingdates: { checkin: '2026-10-01', checkout: '2026-10-02' },
        additionalneeds: 'Breakfast'
      }
      """

    Given path 'booking'
    And request booking
    When method post
    * print '\nCURL EXPORT\n' + toCurl(karate.prevRequest, booking)
    Then status 200
    And match response.bookingid == '#number'
    And match response.booking contains { firstname: '#(booking.firstname)', lastname: '#(booking.lastname)', totalprice: '#(booking.totalprice)' }
    * def bookingId = response.bookingid

    Given path 'booking', bookingId
    And header Accept = 'application/json'
    When method get
    * print '\nCURL EXPORT\n' + toCurl(karate.prevRequest)
    Then status 200
    And match response == booking