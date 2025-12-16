-- Creating a View for Customer Sales Summary
CREATE VIEW CustomerSalesSummary AS
SELECT
    c.customer_id,
    c.full_name,
    SUM(o.total_order_amount) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name;