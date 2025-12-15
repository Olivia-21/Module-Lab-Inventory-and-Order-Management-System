-- STEP 2: SQL DDL CREATE TABLES
Create Database IF NOT EXISTS e_commercedb;
Use e_commercedb;
# drop Database e_commercedb;

-- 1. Customers Table
CREATE TABLE Customers (

    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20),
    shipping_address VARCHAR(200)
);




-- 2. Products Table
CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0)
);

-- 3. Inventory Table
CREATE TABLE Inventory (
    product_id INT PRIMARY KEY,
    quantity_on_hand INT NOT NULL CHECK (quantity_on_hand >= 0),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

DROP TABLE Orders;
-- 4. Orders Table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_order_amount DECIMAL(10,2) NOT NULL CHECK (total_order_amount >= 0),
    order_status VARCHAR(20) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- 5. OrderItems Table
CREATE TABLE OrderItems (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    price_at_purchase DECIMAL(10,2) NOT NULL CHECK (price_at_purchase >= 0),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);



-- Insert Sample Customers
INSERT INTO Customers (full_name, email, phone, shipping_address)
VALUES 
('Olivia Dosimey', 'olivia.dosimey@amalitech.com', '050-990-3401', 'WS-545-6642'),
('Evans', 'evans@gmail.com', '245-889-8901', '456 Adagya St'),
('Michael Jackson', 'michael@gmail.com', '345-678-9012', 'WT Pine Rd'),
('Henry Nana Antwi', 'nanaantwi@gmail.com', '035-119-5567', 'ER Kofo Rd'),
('Michael Jackson', 'michael@gmail.com', '248-111-2212', 'BA Bio Rd'),
('Henry Morgan', 'hmorgan@gmail.com', '123-517-3212', 'Ohio Rd'),
('Keziah Fordjour', 'keziah@gmail.com', '657-914-4912', 'AS Edom Rd'),
('Lily Amoh', 'lily@gmail.com', '248-111-2212', 'WS Benmack Rd'),
('Leonard Messi', 'leonard@gmail.com', '248-111-2212', 'WT Ohio Rd'),
('Emmanuel Godson', 'godson@gmail.com', '543-876-2109', 'AS Adum Rd');


-- Insert Sample Products
INSERT INTO Products (product_name, category, price)
VALUES
('Laptop', 'Electronics', 1200.00),
('T-Shirt', 'Apparel', 25.00),
('Headset', 'Electronics', 40.00),
('Rich Dad Poor Dad', 'Books', 70.00),
('Wrist Watch', 'Apparel', 30.00),
('Iphone', 'Electronics', 2500.00),
('Laptop Bag', 'Apparel', 170.00),
('Wireless Mouse', 'Electronics', 50.00),
('Hard drive', 'Electronics', 150.00),
('Jeans', 'Apparel', 60.00);

-- Insert Inventory Data
INSERT INTO Inventory (product_id, quantity_on_hand)
VALUES
(1, 10),
(2, 50),
(3, 30),
(4, 20),
(5, 40),
(6, 60),
(7, 70),
(8, 15),
(9, 55),
(10, 85);

-- Insert Sample Orders
INSERT INTO Orders (customer_id, order_date, total_order_amount, order_status)
VALUES
(1, '2025-12-01', 1225.00, 'Shipped'),
(2, '2025-12-02', 85.00, 'Pending'),
(3, '2025-12-04', 85.00, 'Pending'),
(4, '2025-12-06', 85.00, 'Delivered'),
(5, '2025-12-07', 85.00, 'Shipped'),
(6, '2025-12-09', 85.00, 'Delivered'),
(7, '2025-12-09', 85.00, 'Shipped'),
(8, '2025-12-12', 85.00, 'Delivered'),
(9, '2025-12-05', 85.00, 'Pending'),
(10, '2025-12-06', 150.00, 'Delivered');

-- Insert OrderItems
INSERT INTO OrderItems (order_id, product_id, quantity, price_at_purchase)
VALUES
(1, 1, 1, 1200.00),
(1, 2, 2, 50.00),
(2, 2, 3, 75.00),
(2, 5, 5, 155.00),
(2, 5, 7, 220.00),
(2, 5, 9, 700.00),
(2, 5, 4, 400.00),
(2, 5, 6, 35.00),
(2, 5, 8, 45.00),
(3, 4, 9, 150.00);

SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Inventory;
SELECT * FROM Orders;
SELECT * FROM OrderItems;

