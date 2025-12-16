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