# E-Commerce Inventory & Order Management Database

## Project Overview
The goal of this project is to **design, build, and query a database** for an e-commerce company's inventory and order management system.  

The knowledge of **data modeling, schema implementation (DDL), and advanced SQL querying (DML)** is implemented to solve realistic business problems.  

---

## Project Objectives

1. **Database Design**
   - Design a normalized, relational database schema in **3rd Normal Form (3NF)** based on given business requirements.

2. **Schema Implementation**
   - Write and execute **SQL DDL scripts** to create tables, relationships, and constraints.

3. **Advanced Querying**
   - Implement complex SQL queries including **joins, aggregations, window functions, and stored procedures** to answer business questions.

4. **Performance Optimization**
   - Use **views and stored procedures** to create reusable and performant query logic.

---

## Project Steps

### Step 1: Database Design (ERD & Schema)
 Create an **Entity-Relationship Diagram (ERD)** mapping all tables, columns, and relationships.

**Business Requirements**

- **Customers**
  - Customer ID
  - Full Name
  - Email
  - Phone
  - Shipping Address

- **Products**
  - Product ID
  - Product Name
  - Category (e.g., Electronics, Apparel, Books)
  - Price

- **Inventory**
  - Track the current stock level (quantity on hand) for each product.

- **Orders**
  - Order ID
  - Customer ID (who placed the order)
  - Order Date
  - Total Order Amount
  - Order Status (e.g., 'Pending', 'Shipped', 'Delivered')

- **Order Items**
  - Each order can have multiple products.
  - Table links products to orders.
  - Columns: Order ID, Product ID, Quantity, Price at purchase time.

**Relationships**
- A **Customer** can have many **Orders**.
- An **Order** can contain many **Products**.
- **Order Items** serves as the bridge table for the many-to-many relationship between Orders and Products.

---

### Step 2: Schema Implementation (DDL)

**1. Create Tables**
- Write `CREATE TABLE` scripts for all tables: Customers, Products, Inventory, Orders, Order Items.

**2. Enforce Data Integrity**
- Use appropriate data types: `VARCHAR`, `INT`, `DECIMAL`, `DATE`.

**3. Keys & Constraints**
- Primary Keys (`PRIMARY KEY`) for all ID fields.
- Foreign Keys (`FOREIGN KEY`) to link tables:
  - `OrderItems` → `Orders` and `Products`
- Not Null constraints (`NOT NULL`) for essential fields like Customer Name, Product Name, Order Date.
- Check constraints (`CHECK`) to ensure Product Price and Inventory Quantity are non-negative.

---

### Step 3: KPI & Advanced SQL Querying (DML)

**Business KPIs**
1. **Total Revenue**  
   - Calculate total revenue from all `Shipped` or `Delivered` orders.
2. **Top 10 Customers**  
   - Show customer names and total amount spent.
3. **Best-Selling Products**  
   - Top 5 products by quantity sold.
4. **Monthly Sales Trend**  
   - Total sales revenue for each month.

**Analytical Queries (Using Window Functions)**
1. **Sales Rank by Category**  
   - Rank products within each category by total revenue.
2. **Customer Order Frequency**  
   - Show the date of the previous order alongside the current order for each customer.

**Performance Optimization**
1. **CustomerSalesSummary View**
   - Pre-calculates total spending per customer to speed up analytics queries.
2. **ProcessNewOrder Stored Procedure**
   - Accepts Customer ID, Product IDs, and Quantities.
   - Performs the following **within a transaction**:
     1. Checks stock availability in Inventory.
     2. Reduces Inventory if stock is sufficient.
     3. Creates a new record in Orders.
     4. Creates new records in Order Items.
     5. Rolls back the transaction and returns an error if stock is insufficient.


---

## How to Use
1. Create all tables and enforce constraints using the provided DDL scripts.
2. Insert sample data into Customers, Products, Inventory, Orders, and Order Items.
3. Run KPI queries to analyze total revenue, top customers, best-selling products, and monthly trends.
4. Use the **CustomerSalesSummary view** for fast analytics.
5. Call the **ProcessNewOrder stored procedure** to safely add new orders and update inventory.

