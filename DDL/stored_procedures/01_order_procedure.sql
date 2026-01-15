-- STORED PROCEDURES FOR TRACKING ORDERS AND ORDER ITEMS
DELIMITER $$
CREATE PROCEDURE ProcessNewOrder(
    IN p_customer_id INT,
    IN p_order_date DATE,
    IN p_order_status VARCHAR(20),
    IN p_product_ids JSON,      -- e.g. '[1,6]'
    IN p_quantities JSON        -- e.g. '[2,1]'
)
-- =========================================================
-- Declaring temporary variables for processing the order
-- =========================================================
BEGIN

START TRANSACTION;
    DECLARE order_total DECIMAL(10,2) DEFAULT 0; -- Total amount for the order
    DECLARE i INT DEFAULT 0;                     -- Loop counter for iterating through products
    DECLARE n INT;                               -- Total number of products in the order
    DECLARE pid INT;                             -- Current product ID being processed
    DECLARE qty INT;                             -- Quantity of the current product in the order
    DECLARE price DECIMAL(10,2);                 -- Price of the current product at purchase time
    DECLARE stock INT;                           -- Available stock for the current product


    -- Get the number of products in the order JSON array
    SET n = JSON_LENGTH(p_product_ids);

-- ============================================================
-- Step 1: Check stock for all products before creating the order
-- Loop through each product to ensure sufficient inventory
-- ============================================================
    WHILE i < n DO
        SET pid = CAST(JSON_EXTRACT(p_product_ids, CONCAT('$[', i, ']')) AS UNSIGNED); -- Extract current product ID from JSON array
        SET qty = CAST(JSON_EXTRACT(p_quantities, CONCAT('$[', i, ']')) AS UNSIGNED);  --Extract quantity of the current product from JSON array

         -- Get available stock for the current product from Inventory table
        SELECT i.quantity_on_hand INTO stock
        FROM Inventory i
        WHERE i.product_id = pid;
        
        -- If stock is insufficient, raise an error and rollback
        IF stock < qty THEN
        -- Rollback all changes if stock is insufficient
            ROLLBACK;
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Not enough stock for one or more products';
        END IF;
        -- Move to the next product in the array (order)
        SET i = i + 1;
    END WHILE;

    -- =============================================
    -- Step 2: Insert the new order
    -- =============================================
    INSERT INTO Orders (customer_id, order_date, total_order_amount, order_status)
    VALUES (p_customer_id, p_order_date, 0, p_order_status);

    SET @new_order_id = LAST_INSERT_ID();

    -- ====================================================
    -- Step 3: Insert order items and update inventory
    -- ====================================================
    SET i = 0;
    WHILE i < n DO
        SET pid = CAST(JSON_EXTRACT(p_product_ids, CONCAT('$[', i, ']')) AS UNSIGNED);
        SET qty = CAST(JSON_EXTRACT(p_quantities, CONCAT('$[', i, ']')) AS UNSIGNED);

        -- Get price at purchase using JOIN 
        SELECT p.price INTO price
        FROM Products p
        JOIN Inventory inv ON inv.product_id = p.product_id
        WHERE p.product_id = pid
        LIMIT 1;

        -- Insert into OrderItems
        INSERT INTO OrderItems (order_id, product_id, quantity, price_at_purchase)
        VALUES (@new_order_id, pid, qty, price);

        -- Reduce inventory
        UPDATE Inventory
        SET quantity_on_hand = quantity_on_hand - qty
        WHERE product_id = pid;

        -- Update total
        SET order_total = order_total + (price * qty);

        SET i = i + 1;
    END WHILE;

    -- 4. Update total order amount
    UPDATE Orders
    SET total_order_amount = order_total
    WHERE order_id = @new_order_id;
    COMMIT;

END$$;

DELIMITER ;


-- Calling Stored Procedure
CALL ProcessNewOrder(
    1,
    '2025-12-16',
    'Pending',
    '[1, 2]',    -- product IDs: Laptop and Iphone
    '[10, 10]'     -- quantities
);