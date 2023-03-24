use Copos;

DROP PROCEDURE IF EXISTS copos_receive_ingredients;
DELIMITER //
CREATE PROCEDURE copos_receive_ingredients
(
	IN p_inventory_group VARCHAR(36),
    IN p_copero_name VARCHAR(10)
)
BEGIN
	DECLARE INVALID_COPERO INT DEFAULT(53000);
    DECLARE INVALID_OPERATION_TYPE INT DEFAULT(53001);
	DECLARE inventory_date DATETIME DEFAULT NOW();
    DECLARE v_copero_id INT;

	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @err_no = MYSQL_ERRNO, @message = MESSAGE_TEXT;
        
        IF (ISNULL(@message)) THEN 
			SET @message = ''; 
        ELSE
            SET @message = CONCAT('Internal error: ', @message);
        END IF;
        
        ROLLBACK;
        
        RESIGNAL SET MESSAGE_TEXT = @message;
	END;
    
    SELECT IFNULL(copero_id, -1) FROM coperos WHERE name = p_copero_name INTO v_copero_id;

    IF (v_copero_id=-1) THEN
		SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = INVALID_EMPLOYEE;
    END IF;
    
	IF EXISTS(SELECT check_status_id FROM tmpInventoryData WHERE check_status_id > 3 ) THEN
		SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = INVALID_STATUS_ID;
    END IF;
    
	IF EXISTS(SELECT check_type_id FROM tmpInventoryData WHERE check_type_id > 2 ) THEN
		SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = INVALID_CHECK_TYPE;
    END IF;

	SET autocommit = 0;
	START TRANSACTION;
		INSERT INTO inventory_checks (check_status_id, check_type_id, first_copero, second_copero, updated_at, created_at, computer, username, checksum, real_amount, inventory_id)
        SELECT tid.check_status_id, tid.check_type_id, tid.copero_id, v_copero_id, inventory_date, inventory_date, "me", "root", SHA2("password",256), tid.real_amount, tid.inventory_id
        FROM tmpInventoryData tid
        WHERE inventorygroup = p_inventory_group;
	COMMIT;
    
END//
DELIMITER ;

DROP TABLE IF EXISTS tmpInventoryData;
create table tmpInventoryData (
	inventorygroup VARCHAR(36),
	copero_id INT,
	inventory_id INT,
    real_amount DECIMAL(12,2),
    check_status_id INT,
    check_type_id INT
);

SET @migrupo = UUID();

INSERT INTO tmpInventoryData (inventorygroup, copero_id, inventory_id, real_amount, check_status_id, check_type_id) 
VALUES
	(@migrupo, 1, 31, 5000, 3, 1),  
	(@migrupo, 1, 35, 5000, 3, 1),
	(@migrupo, 1, 38, 5000, 3, 1);

call copos_receive_ingredients(@migrupo, "Rocco");
