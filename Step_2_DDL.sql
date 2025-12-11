-- STEP 2: SQL DDL CREATE TABLES
Create Database e_commercedb;
Use e_commercedb;

-- 1. Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    Phone VARCHAR(20),
    ShippingAddress VARCHAR(200)
);

-- 2. Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    Price DECIMAL(10,2) NOT NULL CHECK (Price >= 0)
);

-- 3. Inventory Table
CREATE TABLE Inventory (
    ProductID INT PRIMARY KEY,
    QuantityOnHand INT NOT NULL CHECK (QuantityOnHand >= 0),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


-- 4. Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10,2) NOT NULL CHECK (TotalAmount >= 0),
    OrderStatus VARCHAR(20) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- 5. OrderItems Table
CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    PriceAtPurchase DECIMAL(10,2) NOT NULL CHECK (PriceAtPurchase >= 0),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);



-- Insert Sample Customers
INSERT INTO Customers (FullName, Email, Phone, ShippingAddress)
VALUES 
('Olivia Dosimey', 'olivia.dosimey@amalitech.com', '0509903401', 'WS-545-6642'),
('Evans', 'evans@gmail.com', '245-889-8901', '456 Adagya St'),
('Michael Jackson', 'michael@gmail.com', '345-678-9012', 'WT Pine Rd');


-- Insert Sample Products
INSERT INTO Products (ProductName, Category, Price)
VALUES
('Laptop', 'Electronics', 1200.00),
('T-Shirt', 'Apparel', 25.00),
('Headset', 'Electronics', 40.00),
('Hard drive', 'Electronics', 150.00),
('Jeans', 'Apparel', 60.00);


-- Insert Inventory Data
INSERT INTO Inventory (ProductID, QuantityOnHand)
VALUES
(1, 10),
(2, 50),
(3, 30),
(4, 20),
(5, 40);

-- Insert Sample Orders
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount, OrderStatus)
VALUES
(1, '2025-12-01', 1225.00, 'Shipped'),
(2, '2025-12-02', 85.00, 'Delivered'),
(1, '2025-12-05', 150.00, 'Pending');

-- Insert OrderItems
INSERT INTO OrderItems (OrderID, ProductID, Quantity, PriceAtPurchase)
VALUES
(1, 1, 1, 1200.00),
(1, 2, 1, 25.00),
(2, 2, 2, 25.00),
(2, 5, 1, 35.00),
(3, 4, 1, 150.00);

