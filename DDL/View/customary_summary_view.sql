-- Creating a View for Customer Sales Summary
CREATE VIEW CustomerSalesSummary AS
SELECT
    c.customer_id,
    c.full_name,
    SUM(o.total_order_amount) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name;


-- Creating a view for Shipped and Delivery Orders
CREATE VIEW shipped_delivered_orders AS
SELECT o.order_id, o.customer_id, o.total_order_amount
FROM Orders o
WHERE o.order_status IN ('Shipped', 'Delivered');

-- show summary in Customer sales
select * from customersalessummary;