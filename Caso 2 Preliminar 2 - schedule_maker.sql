DELIMITER //
DROP PROCEDURE IF EXISTS schedule_maker;
CREATE PROCEDURE `schedule_maker` ()
BEGIN
  DECLARE cur_date DATE;
  DECLARE last_insert_id_iv INT;
  DECLARE last_insert_id_cb INT;
  DECLARE iv_counter INT DEFAULT 1;
  DECLARE cb_counter INT DEFAULT 1;
  DECLARE ingr_counter INT DEFAULT 1;
  DECLARE ing_quant DECIMAL(12,2);
  SET cur_date = '2023-03-15';

  WHILE cur_date <= '2023-03-15' DO
    INSERT INTO schedules (copero_id, carrito_id, playa_id, pickup_date, dropoff_date, pickup_location, dropoff_location, updated_at, created_at, computer, username, checksum)
    VALUES
		(1, 1, 1, CONCAT(cur_date, " 09:00:00"), CONCAT(cur_date, " 13:00:00"), "Tamarindo", "Tamarindo", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (2, 1, 1, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 17:00:00"), "Tamarindo", "Tamarindo", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (3, 2, 1, CONCAT(cur_date, " 09:00:00"), CONCAT(cur_date, " 13:00:00"), "Tamarindo", "Tamarindo", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (4, 2, 1, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 17:00:00"), "Tamarindo", "Tamarindo", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (5, 3, 1, CONCAT(cur_date, " 09:00:00"), CONCAT(cur_date, " 13:00:00"), "Tamarindo", "Tamarindo", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (6, 3, 1, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 17:00:00"), "Tamarindo", "Tamarindo", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (7, 4, 1, CONCAT(cur_date, " 09:00:00"), CONCAT(cur_date, " 13:00:00"), "Tamarindo", "Tamarindo", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (8, 4, 1, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 17:00:00"), "Tamarindo", "Tamarindo", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (9, 5, 1, CONCAT(cur_date, " 09:00:00"), CONCAT(cur_date, " 13:00:00"), "Tamarindo", "Tamarindo", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (10, 5, 1, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 17:00:00"), "Tamarindo", "Tamarindo", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (11, 6, 2, CONCAT(cur_date, " 09:00:00"), CONCAT(cur_date, " 13:00:00"), "Samara", "Samara", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (12, 6, 2, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 17:00:00"), "Samara", "Samara", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (13, 7, 2, CONCAT(cur_date, " 09:00:00"), CONCAT(cur_date, " 13:00:00"), "Samara", "Samara", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (14, 7, 2, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 17:00:00"), "Samara", "Samara", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (15, 8, 2, CONCAT(cur_date, " 09:00:00"), CONCAT(cur_date, " 13:00:00"), "Samara", "Samara", cur_date, cur_date, "me", "root", SHA2("password",256)),
		(16, 8, 2, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 17:00:00"), "Samara", "Samara", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (17, 9, 2, CONCAT(cur_date, " 09:00:00"), CONCAT(cur_date, " 13:00:00"), "Samara", "Samara", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (18, 9, 2, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 17:00:00"), "Samara", "Samara", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (19, 10, 2, CONCAT(cur_date, " 09:00:00"), CONCAT(cur_date, " 13:00:00"), "Samara", "Samara", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (20, 10, 2, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 17:00:00"), "Samara", "Samara", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (21, 11, 3, CONCAT(cur_date, " 09:00:00"), CONCAT(cur_date, " 13:00:00"), "Hermosa", "Hermosa", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (22, 11, 3, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 17:00:00"), "Hermosa", "Hermosa", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (23, 12, 3, CONCAT(cur_date, " 09:00:00"), CONCAT(cur_date, " 13:00:00"), "Hermosa", "Hermosa", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (24, 12, 3, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 17:00:00"), "Hermosa", "Hermosa", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (25, 13, 3, CONCAT(cur_date, " 09:00:00"), CONCAT(cur_date, " 13:00:00"), "Hermosa", "Hermosa", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (26, 13, 3, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 17:00:00"), "Hermosa", "Hermosa", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (27, 14, 3, CONCAT(cur_date, " 09:00:00"), CONCAT(cur_date, " 13:00:00"), "Hermosa", "Hermosa", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (28, 14, 3, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 17:00:00"), "Hermosa", "Hermosa", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (29, 15, 3, CONCAT(cur_date, " 09:00:00"), CONCAT(cur_date, " 13:00:00"), "Hermosa", "Hermosa", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (30, 15, 3, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 17:00:00"), "Hermosa", "Hermosa", cur_date, cur_date, "me", "root", SHA2("password",256));
    SET ingr_counter = 1;
    WHILE ingr_counter <=13 DO  
		SET iv_counter = 1;
		SET ing_quant =
			CASE 
				WHEN ingr_counter < 11 THEN 3000.00
				WHEN ingr_counter = 11 THEN 6000.00
				WHEN ingr_counter = 12 THEN 1500.00
                WHEN ingr_counter = 13 THEN 750.00
			END;
            
		WHILE iv_counter <= 15 DO
			INSERT INTO inventories (car_id, ingredient_id, quantity, updated_at, created_at, operation_type)
			VALUE
				(iv_counter, ingr_counter, ing_quant, CONCAT(cur_date, " 09:00:00"), CONCAT(cur_date, " 09:00:00"), "refill");
			SET last_insert_id_iv = LAST_INSERT_ID();
			
			INSERT INTO inventory_checks (check_status_id, check_type_id, first_copero, second_copero, updated_at, created_at, computer, username, checksum, real_amount, inventory_id)
			VALUE
				(2, 2, iv_counter + iv_counter - 1, NULL, CONCAT(cur_date, " 09:00:00"), CONCAT(cur_date, " 09:00:00"), "me", "root", SHA2("password",256), ing_quant, last_insert_id_iv);
			SET iv_counter = iv_counter + 1;
		END WHILE;
        SET ingr_counter = ingr_counter + 1;
	END WHILE;
    
    SET ingr_counter = 1;
	WHILE ingr_counter <=13 DO  
		SET iv_counter = 1;
		SET ing_quant =
			CASE 
				WHEN ingr_counter < 11 THEN 3000.00
				WHEN ingr_counter = 11 THEN 6000.00
				WHEN ingr_counter = 12 THEN 1500.00
                WHEN ingr_counter = 13 THEN 750.00
			END;
            
		WHILE iv_counter <= 15 DO
			INSERT INTO inventories (car_id, ingredient_id, quantity, updated_at, created_at, operation_type)
			VALUE
				(iv_counter, ingr_counter, ing_quant, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 13:00:00"), "refill");
			SET last_insert_id_iv = LAST_INSERT_ID();
			
			INSERT INTO inventory_checks (check_status_id, check_type_id, first_copero, second_copero, updated_at, created_at, computer, username, checksum, real_amount, inventory_id)
			VALUE
				(2, 2, iv_counter + iv_counter, NULL, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 13:00:00"), "me", "root", SHA2("password",256), ing_quant, last_insert_id_iv);
			SET iv_counter = iv_counter + 1;
		END WHILE;
        SET ingr_counter = ingr_counter + 1;
	END WHILE;
	SET cb_counter = 1;
	WHILE cb_counter <= 15 DO
		INSERT INTO cashboxes (car_id, created_at, updated_at, operation_type, amount)
		VALUE
			(cb_counter, CONCAT(cur_date, " 09:00:00"), CONCAT(cur_date, " 09:00:00"), "credito", 10000.00);
		SET last_insert_id_cb = LAST_INSERT_ID();
        
        INSERT INTO cashbox_checks (check_status_id, check_type_id, first_copero, second_copero, updated_at, created_at, computer, username, checksum, real_amount, cashbox_id)
		VALUE
			(2, 2, cb_counter + cb_counter - 1, NULL, CONCAT(cur_date, " 09:00:00"), CONCAT(cur_date, " 09:00:00"), "me", "root", SHA2("password",256), 10000.00, last_insert_id_cb);
        
		SET cb_counter = cb_counter + 1;
	END WHILE;

    SET cur_date = DATE_ADD(cur_date, INTERVAL 1 DAY);
  END WHILE;
  
END //
DELIMITER ;