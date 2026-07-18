CREATE DATABASE IF NOT EXISTS booking_breakdown;
USE booking_breakdown;

CREATE TABLE IF NOT EXISTS hotel_bookings (
    booking_id INT AUTO_INCREMENT,
    booking_date DATE NOT NULL,
    cancel_date DATE,
    checkin_date DATE NOT NULL,
    checkout_date DATE NOT NULL,
    is_canceled BOOL NOT NULL,
    PRIMARY KEY (booking_id)
);

LOAD DATA INFILE '/datasets/booking-breakdown/hotel_bookings.csv'
INTO TABLE hotel_bookings
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(booking_id, booking_date, @cancel_date, checkin_date, checkout_date, is_canceled)
SET cancel_date = NULLIF(TRIM(@cancel_date), '')
