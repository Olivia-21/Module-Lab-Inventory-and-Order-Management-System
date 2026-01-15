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