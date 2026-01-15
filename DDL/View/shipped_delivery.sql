-- Creating a view for Shipped and Delivery Orders
CREATE VIEW shipped_delivered_orders AS
SELECT o.order_id, o.customer_id, o.total_order_amount
FROM Orders o
WHERE o.order_status IN ('Shipped', 'Delivered');