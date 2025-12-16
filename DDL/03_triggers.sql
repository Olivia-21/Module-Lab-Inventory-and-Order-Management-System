# Insert order trigger
DELIMITER $$
CREATE TRIGGER trg_insert_order
AFTER INSERT ON orders
    FOR EACH ROW
    BEGIN
        CALL log_event ('orders', New.order_id, 'INSERT', CONCAT('Order ', NEW.order_id, 'inserted.'));
    END $$;

DELIMITER ;

#Delete trigger on Orders
DELIMITER $$
CREATE TRIGGER trg_order_delete
AFTER DELETE ON orders
    FOR EACH ROW
    BEGIN
        CALL log_event('orders', OLD.order_id, 'DELETE', CONCAT('Order ', OLD.order_id, 'deleted. '));
    END $$;
DELIMITER ;

#Update trigger on Orders
DELIMITER $$
CREATE TRIGGER trg_order_update
AFTER UPDATE ON orders
    FOR EACH ROW
    BEGIN
        CALL log_event('orders',NEW.order_id, 'UPDATE', CONCAT('Order', OLD.order_id, 'updated to ', NEW.order_id));
    END $$;
DELIMITER ;


#Update trigger on Inventory (Items in Stock)
DELIMITER $$
CREATE TRIGGER trg_inventory_update
AFTER UPDATE ON inventory
    FOR EACH ROW
    BEGIN
        CALL log_event('inventory',  NEW.product_id, 'UPDATE', CONCAT('Inventory updated for product ', NEW.product_id));
    END $$;
DELIMITER ;


#trigger Customer Delete
DELIMITER $$
CREATE TRIGGER trg_customer_delete
AFTER DELETE ON customers
    FOR EACH ROW
    BEGIN
        CALL log_event('customers', OLD.customer_id, 'DELETE', CONCAT('Customer id ', OLD.customer_id, 'deleted.'));
    END $$;

DELIMITER ;

