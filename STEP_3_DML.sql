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
FROM Customers cexit

JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name;


DELIMITER //

CREATE PROCEDURE ProcessNewOrder(
    IN p_customer_id INT,
    IN p_product_id INT,
    IN p_quantity INT
)
BEGIN
    DECLARE v_Price DECIMAL(10,2);
    DECLARE v_Stock INT;
    DECLARE v_OrderID INT;

    START TRANSACTION;

    -- Check inventory
    SELECT Price, quantity_on_hand INTO v_Price, v_Stock
    FROM Products p
    JOIN Inventory i ON p.product_id = i.product_id
    WHERE p.product_id = p_product_id;

    IF v_Stock < p_Quantity THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient stock';
    ELSE
        -- Reduce inventory
        UPDATE Inventory
        SET quantity_on_hand = quantity_on_hand - p_quantity
        WHERE product_id = p_product_id;

        -- Create new order
        INSERT INTO Orders (customer_id, order_date, total_order_amount, order_status)
        VALUES (p_customer_id, CURDATE(), v_Price * p_quantity, 'Pending');

        SET v_OrderID = LAST_INSERT_ID();

        -- Insert into order items
        INSERT INTO OrderItems (order_id, product_id, Quantity, price_at_purchase)
        VALUES (v_OrderID, p_product_id, p_quantity, v_Price);

        COMMIT;
    END IF;
END //

DELIMITER ;



