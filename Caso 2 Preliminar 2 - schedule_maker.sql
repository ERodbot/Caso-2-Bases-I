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
  DECLARE cur_date_mor DATETIME;
  DECLARE cur_date_eve DATETIME;
  DECLARE cur_date_nit DATETIME;
  DECLARE sha2_var VARBINARY(150);
  SET cur_date = '2023-03-15';
  SET sha2_var = SHA2("password",256);
  
  WHILE cur_date <= '2023-09-15' DO
	SET cur_date_mor = CONCAT(cur_date, " 09:00:00");
    SET cur_date_eve = CONCAT(cur_date, " 13:00:00");
	SET cur_date_nit = CONCAT(cur_date, " 17:00:00");
    
    INSERT INTO schedules (copero_id, carrito_id, playa_id, pickup_date, dropoff_date, pickup_location, dropoff_location, updated_at, created_at, computer, username, checksum)
    VALUES
		(1, 1, 1, cur_date_mor, cur_date_eve, "Tamarindo", "Tamarindo", cur_date, cur_date, "me", "root", sha2_var),
        (2, 1, 1, cur_date_eve, cur_date_nit, "Tamarindo", "Tamarindo", cur_date, cur_date, "me", "root", sha2_var),
        (3, 2, 1, cur_date_mor, cur_date_eve, "Tamarindo", "Tamarindo", cur_date, cur_date, "me", "root", sha2_var),
        (4, 2, 1, cur_date_eve, cur_date_nit, "Tamarindo", "Tamarindo", cur_date, cur_date, "me", "root", sha2_var),
        (5, 3, 1, cur_date_mor, cur_date_eve, "Tamarindo", "Tamarindo", cur_date, cur_date, "me", "root", sha2_var),
        (6, 3, 1, cur_date_eve, cur_date_nit, "Tamarindo", "Tamarindo", cur_date, cur_date, "me", "root", sha2_var),
        (7, 4, 1, cur_date_mor, cur_date_eve, "Tamarindo", "Tamarindo", cur_date, cur_date, "me", "root", sha2_var),
        (8, 4, 1, cur_date_eve, cur_date_nit, "Tamarindo", "Tamarindo", cur_date, cur_date, "me", "root", sha2_var),
        (9, 5, 1, cur_date_mor, cur_date_eve, "Tamarindo", "Tamarindo", cur_date, cur_date, "me", "root", sha2_var),
        (10, 5, 1, cur_date_eve, cur_date_nit, "Tamarindo", "Tamarindo", cur_date, cur_date, "me", "root", sha2_var),
        (11, 6, 2, cur_date_mor, cur_date_eve, "Samara", "Samara", cur_date, cur_date, "me", "root", sha2_var),
        (12, 6, 2, cur_date_eve, cur_date_nit, "Samara", "Samara", cur_date, cur_date, "me", "root", sha2_var),
        (13, 7, 2, cur_date_mor, cur_date_eve, "Samara", "Samara", cur_date, cur_date, "me", "root", sha2_var),
        (14, 7, 2, cur_date_eve, cur_date_nit, "Samara", "Samara", cur_date, cur_date, "me", "root", sha2_var),
        (15, 8, 2, cur_date_mor, cur_date_eve, "Samara", "Samara", cur_date, cur_date, "me", "root", sha2_var),
		(16, 8, 2, cur_date_eve, cur_date_nit, "Samara", "Samara", cur_date, cur_date, "me", "root", sha2_var),
        (17, 9, 2, cur_date_mor, cur_date_eve, "Samara", "Samara", cur_date, cur_date, "me", "root", sha2_var),
        (18, 9, 2, cur_date_eve, cur_date_nit, "Samara", "Samara", cur_date, cur_date, "me", "root", sha2_var),
        (19, 10, 2, cur_date_mor, cur_date_eve, "Samara", "Samara", cur_date, cur_date, "me", "root", sha2_var),
        (20, 10, 2, cur_date_eve, cur_date_nit, "Samara", "Samara", cur_date, cur_date, "me", "root", sha2_var),
        (21, 11, 3, cur_date_mor, cur_date_eve, "Hermosa", "Hermosa", cur_date, cur_date, "me", "root", sha2_var),
        (22, 11, 3, cur_date_eve, cur_date_nit, "Hermosa", "Hermosa", cur_date, cur_date, "me", "root", sha2_var),
        (23, 12, 3, cur_date_mor, cur_date_eve, "Hermosa", "Hermosa", cur_date, cur_date, "me", "root", sha2_var),
        (24, 12, 3, cur_date_eve, cur_date_nit, "Hermosa", "Hermosa", cur_date, cur_date, "me", "root", sha2_var),
        (25, 13, 3, cur_date_mor, cur_date_eve, "Hermosa", "Hermosa", cur_date, cur_date, "me", "root", sha2_var),
        (26, 13, 3, cur_date_eve, cur_date_nit, "Hermosa", "Hermosa", cur_date, cur_date, "me", "root", sha2_var),
        (27, 14, 3, cur_date_mor, cur_date_eve, "Hermosa", "Hermosa", cur_date, cur_date, "me", "root", sha2_var),
        (28, 14, 3, cur_date_eve, cur_date_nit, "Hermosa", "Hermosa", cur_date, cur_date, "me", "root", sha2_var),
        (29, 15, 3, cur_date_mor, cur_date_eve, "Hermosa", "Hermosa", cur_date, cur_date, "me", "root", sha2_var),
        (30, 15, 3, cur_date_eve, cur_date_nit, "Hermosa", "Hermosa", cur_date, cur_date, "me", "root", sha2_var);
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
				(iv_counter, ingr_counter, ing_quant, cur_date_mor, cur_date_mor, "refill");
			SET last_insert_id_iv = LAST_INSERT_ID();
			
			INSERT INTO inventory_checks (check_status_id, check_type_id, first_copero, second_copero, updated_at, created_at, computer, username, checksum, real_amount, inventory_id)
			VALUE
				(2, 2, iv_counter + iv_counter - 1, NULL, cur_date_mor, cur_date_mor, "me", "root", sha2_var, ing_quant, last_insert_id_iv);
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
				(iv_counter, ingr_counter, ing_quant, cur_date_eve, cur_date_eve, "refill");
			SET last_insert_id_iv = LAST_INSERT_ID();
			
			INSERT INTO inventory_checks (check_status_id, check_type_id, first_copero, second_copero, updated_at, created_at, computer, username, checksum, real_amount, inventory_id)
			VALUE
				(2, 2, iv_counter + iv_counter, NULL, cur_date_eve, cur_date_eve, "me", "root", sha2_var, ing_quant, last_insert_id_iv);
			SET iv_counter = iv_counter + 1;
		END WHILE;
        SET ingr_counter = ingr_counter + 1;
	END WHILE;
	SET cb_counter = 1;
	WHILE cb_counter <= 15 DO
		INSERT INTO cashboxes (car_id, created_at, updated_at, operation_type, amount)
		VALUE
			(cb_counter, cur_date_mor, cur_date_mor, "credito", 10000.00);
		SET last_insert_id_cb = LAST_INSERT_ID();
        
        INSERT INTO cashbox_checks (check_status_id, check_type_id, first_copero, second_copero, updated_at, created_at, computer, username, checksum, real_amount, cashbox_id)
		VALUE
			(2, 2, cb_counter + cb_counter - 1, NULL, cur_date_mor, cur_date_mor, "me", "root", sha2_var, 10000.00, last_insert_id_cb);
        
		SET cb_counter = cb_counter + 1;
	END WHILE;

    SET cur_date = DATE_ADD(cur_date, INTERVAL 1 DAY);
  END WHILE;
  
END //
DELIMITER ;