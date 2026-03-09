SELECT
    booking_month,
    customer_id,
    SUM(booking_amount) AS bookings
FROM sales_bookings
GROUP BY 1, 2
