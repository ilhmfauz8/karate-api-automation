# Karate Booking API Automation

Karate API automation for the public [Restful Booker](https://restful-booker.herokuapp.com/) API.

## Prerequisites

- Java 21 or newer
- Maven 3.9 or newer
- Internet access

## Run

Run the booking scenario (the only test in this project):

```shell
mvn test
```

Run it by tag:

```shell
mvn test -Dtest=runners.BookingTest '-Dkarate.options=--tags @booking'
```

The scenario creates a booking with `POST /booking`, checks the response status, `firstname`, `lastname`, and `totalprice`, extracts the generated `bookingid`, then calls `GET /booking/{bookingid}` and compares the returned booking with the submitted payload.

Both requests send `Accept: application/json`.

## Project structure

```text
src/test
├── java/runners/BookingTest.java
└── resources
    ├── booking/create-and-retrieve-booking.feature
    ├── karate-config.js
    └── logback-test.xml
```

Karate writes its HTML report to `target/karate-reports/karate-summary.html`.