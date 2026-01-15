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

-- Insert Sample Orders
INSERT INTO Orders (customer_id, order_date, total_order_amount, order_status) VALUES
(1, '2024-01-10', 1350.00, 'Delivered'),
(1, '2024-05-05', 1150.00, 'Delivered'),
(2, '2024-01-15', 800.00, 'Shipped'),
(2, '2024-10-10', 800.00, 'Shipped'),
(3, '2024-02-01', 175.00, 'Delivered'),
(4, '2024-02-10', 60.00, 'Pending'),
(5, '2024-03-05', 90.00, 'Delivered'),
(6, '2024-03-12', 1200.00, 'Shipped'),
(7, '2024-04-01', 45.00, 'Delivered'),
(8, '2024-04-18', 85.00, 'Delivered'),
(9, '2024-05-03', 150.00, 'Pending'),
(10,'2024-05-20', 25.00, 'Delivered');


-- Insert Sample OrderItems
INSERT INTO OrderItems (order_id, product_id, quantity, price_at_purchase) VALUES
(1, 1, 1, 1200.00),
(1, 3, 1, 150.00),
(2, 2, 1, 800.00),
(3, 4, 3, 25.00),
(4, 5, 1, 60.00),
(5, 6, 1, 90.00),
(6, 1, 1, 1200.00),
(7, 10, 1, 45.00),
(8, 8, 1, 85.00),
(9, 3, 1, 150.00);



-- Insert Inventory Data
INSERT INTO Inventory (product_id, quantity_on_hand)
VALUES
(1, 100),
(2, 500),
(3, 300),
(4, 200),
(5, 400),
(6, 600),
(7, 700),
(8, 150),
(9, 550),
(10, 805);

select * from Customers;
select * from Orders;
select * from Products;
select * from OrderItems;
select * from Inventory;