SELECT
    c.customer_id,
    c.customer_name,
    c.segment,
    c.region,
    b.booking_month,
    COALESCE(b.bookings, 0) AS bookings,
    COALESCE(r.recognized_revenue, 0) AS recognized_revenue,
    COALESCE(r.recurring_revenue, 0) AS recurring_revenue,
    COALESCE(u.active_users, 0) AS active_users,
    COALESCE(u.usage_events, 0) AS usage_events
FROM dim_customers c
LEFT JOIN fct_bookings b
    ON c.customer_id = b.customer_id
LEFT JOIN fct_revenue r
    ON c.customer_id = r.customer_id
   AND b.booking_month = r.revenue_month
LEFT JOIN fct_usage u
    ON c.customer_id = u.customer_id
   AND b.booking_month = u.usage_month
