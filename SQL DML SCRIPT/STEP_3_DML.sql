-- Total Revenue (Shipped or Delivered)
SELECT SUM(TotalAmount) AS TotalRevenue
FROM Orders
WHERE OrderStatus IN ('Shipped', 'Delivered');

-- Top 10 Customers by Spending
SELECT c.FullName, SUM(o.TotalAmount) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FullName
ORDER BY TotalSpent DESC
LIMIT 10;

-- Top 5 Best-Selling Products by Quantity
SELECT p.ProductName, SUM(oi.Quantity) AS TotalSold
FROM Products p
JOIN OrderItems oi ON p.ProductID = oi.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalSold DESC
LIMIT 5;

-- Monthly Sales Trend
SELECT DATE_FORMAT(OrderDate, '%Y-%m') AS Month, SUM(TotalAmount) AS TotalRevenue
FROM Orders
GROUP BY Month
ORDER BY Month;


-- Sales Rank by Category
SELECT
    p.Category,
    p.ProductName,
    SUM(oi.Quantity * oi.PriceAtPurchase) AS Revenue,
    RANK() OVER (PARTITION BY p.Category ORDER BY SUM(oi.Quantity * oi.PriceAtPurchase) DESC) AS RankInCategory
FROM Products p
JOIN OrderItems oi ON p.ProductID = oi.ProductID
GROUP BY p.Category, p.ProductName;

-- Customer Order Frequency
SELECT
    c.FullName,
    o.OrderID,
    o.OrderDate,
    LAG(o.OrderDate) OVER (PARTITION BY c.CustomerID ORDER BY o.OrderDate) AS PreviousOrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
ORDER BY c.CustomerID, o.OrderDate;


CREATE VIEW CustomerSalesSummary AS
SELECT 
    c.CustomerID,
    c.FullName,
    SUM(o.TotalAmount) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FullName;


DELIMITER //

CREATE PROCEDURE ProcessNewOrder(
    IN p_CustomerID INT,
    IN p_ProductID INT,
    IN p_Quantity INT
)
BEGIN
    DECLARE v_Price DECIMAL(10,2);
    DECLARE v_Stock INT;
    DECLARE v_OrderID INT;

    START TRANSACTION;

    -- Check inventory
    SELECT Price, QuantityOnHand INTO v_Price, v_Stock
    FROM Products p
    JOIN Inventory i ON p.ProductID = i.ProductID
    WHERE p.ProductID = p_ProductID;

    IF v_Stock < p_Quantity THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient stock';
    ELSE
        -- Reduce inventory
        UPDATE Inventory
        SET QuantityOnHand = QuantityOnHand - p_Quantity
        WHERE ProductID = p_ProductID;

        -- Create new order
        INSERT INTO Orders (CustomerID, OrderDate, TotalAmount, OrderStatus)
        VALUES (p_CustomerID, CURDATE(), v_Price * p_Quantity, 'Pending');

        SET v_OrderID = LAST_INSERT_ID();

        -- Insert into order items
        INSERT INTO OrderItems (OrderID, ProductID, Quantity, PriceAtPurchase)
        VALUES (v_OrderID, p_ProductID, p_Quantity, v_Price);

        COMMIT;
    END IF;
END //

DELIMITER ;



