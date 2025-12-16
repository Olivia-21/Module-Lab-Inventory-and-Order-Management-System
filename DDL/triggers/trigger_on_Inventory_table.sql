#Update trigger on Inventory (Items in Stock)
DELIMITER $$
CREATE TRIGGER trg_inventory_update
AFTER UPDATE ON inventory
    FOR EACH ROW
    BEGIN
        CALL log_event('inventory',  NEW.product_id, 'UPDATE', CONCAT('Inventory updated for product ', NEW.product_id));
    END $$;
DELIMITER ;