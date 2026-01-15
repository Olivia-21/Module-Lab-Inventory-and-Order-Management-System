-- STEP 2: SQL DDL CREATE TABLES
Create Database IF NOT EXISTS e_commercedb;
Use e_commercedb;


-- 1. Customers Table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
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

-- 3. Orders Table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_order_amount DECIMAL(10,2) NOT NULL CHECK (total_order_amount >= 0),
    order_status VARCHAR(20) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    INDEX idx_orders_status (order_status),
    INDEX idx_orders_status_date (order_status, order_date)
    
);

-- 4. OrderItems Table
CREATE TABLE OrderItems (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    price_at_purchase DECIMAL(10,2) NOT NULL CHECK (price_at_purchase >= 0),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    INDEX idx_orderitems_order_id (order_id),
    INDEX idx_orderitems_product_id (product_id)     
);


-- 5. Inventory Table
CREATE TABLE Inventory (
    product_id INT PRIMARY KEY,
    quantity_on_hand INT NOT NULL CHECK (quantity_on_hand >= 0),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);


-- Log Table for event triggers
CREATE TABLE audit_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    entity VARCHAR(50),
    entity_id INT,
    action VARCHAR(20),
    log_message VARCHAR(100),
    log_date DATETIME
);


