#trigger Customer Delete
DELIMITER $$
CREATE TRIGGER trg_customer_delete
AFTER DELETE ON customers
    FOR EACH ROW
    BEGIN
        CALL log_event('customers', OLD.customer_id, 'DELETE', CONCAT('Customer id ', OLD.customer_id, 'deleted.'));
    END $$;

DELIMITER ;

