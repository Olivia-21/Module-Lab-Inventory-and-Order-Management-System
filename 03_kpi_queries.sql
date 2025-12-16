-- Business KPI Queries
-- Total Revenue (Shipped or Delivered)
SELECT SUM(total_order_amount) AS total_revenue
FROM Orders
WHERE order_status IN ('Shipped', 'Delivered');

-- Top 10 Customers by Spending
SELECT c.full_name, SUM(o.total_order_amount) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name
ORDER BY total_spent DESC
LIMIT 10;

-- Top 5 Best-Selling Products by Quantity
SELECT p.product_name, SUM(oi.quantity) AS total_sold
FROM Products p
JOIN OrderItems oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_sold DESC
LIMIT 5;

-- Monthly Sales Trend
SELECT DATE_FORMAT(order_date, '%Y-%m') AS Month, SUM(total_order_amount) AS TotalRevenue
FROM Orders
GROUP BY Month
ORDER BY Month;


-- Analytical Queries using Window Functions
-- Sales Rank by Category
SELECT
    p.category,
    p.product_name,
    SUM(oi.quantity * oi.price_at_purchase) AS Revenue,
    RANK() OVER (PARTITION BY p.category ORDER BY SUM(oi.quantity * oi.price_at_purchase) DESC) AS rank_in_category
FROM Products p
JOIN OrderItems oi ON p.product_id = oi.product_id
GROUP BY p.Category, p.product_name;

-- Customer Order Frequency
SELECT
    c.full_name,
    o.order_id,
    o.order_date,
    LAG(o.order_date) OVER (PARTITION BY c.customer_id ORDER BY o.order_date) AS previous_order_date
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
ORDER BY c.customer_id, o.order_date;


-- Creating a View for Customer Sales Summary
CREATE VIEW CustomerSalesSummary AS
SELECT 
    c.customer_id,
    c.full_name,
    SUM(o.total_order_amount) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name;





