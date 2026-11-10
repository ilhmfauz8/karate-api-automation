package runners;

import io.karatelabs.junit6.Karate;

class BookingTest {

    @Karate.Test
    Karate testBooking() {
        return Karate.run("classpath:booking");
    }
}