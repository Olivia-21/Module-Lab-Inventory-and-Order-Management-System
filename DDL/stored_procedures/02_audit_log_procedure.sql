#Stored Procedure for handling multiple events
DELIMITER $$
CREATE PROCEDURE log_event(
    event_entity VARCHAR(50),
    event_id INT,
    event_action VARCHAR(30),
    event_message VARCHAR(100)
)
    BEGIN
        INSERT INTO audit_logs (entity, entity_id, action,log_message, log_date)
            VALUES (event_entity, event_id, event_action, event_message, NOW());
    END $$
DELIMITER ;