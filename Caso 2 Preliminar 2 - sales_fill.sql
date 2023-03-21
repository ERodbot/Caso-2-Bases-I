DELIMITER //
DROP PROCEDURE IF EXISTS `sales_fill`;
CREATE PROCEDURE `sales_fill` ()
BEGIN

  DECLARE cur_date DATE;
  DECLARE sale_counter INT DEFAULT 0;
  DECLARE sale_range INT DEFAULT 0;
  DECLARE copero_counter INT DEFAULT 0;
  DECLARE iv_id INT;
  DECLARE mod_dia INT;
  DECLARE beach_id_ INT;
  DECLARE horas TIME;
  DECLARE last_insert_id_iv INT;
  DECLARE last_insert_id_od INT;
  DECLARE last_insert_id_inv INT;
  DECLARE last_insert_id_cb INT;
  DECLARE rand_prod_id INT;
  DECLARE rand_prod_quant INT;
  DECLARE price DECIMAL(10,2);
  DECLARE sha2_var VARBINARY(150);
  DECLARE true_date DATETIME;
  SET cur_date = '2023-03-14';
  SET sha2_var = SHA2("password",256);
  
  WHILE cur_date < '2023-3-15' DO
	SET cur_date = DATE_ADD(cur_date, INTERVAL 1 DAY);
	SET copero_counter = 0;
 	WHILE copero_counter < 30 DO
		SET copero_counter = copero_counter + 1;
        
		SET beach_id_ =
			CASE 
				WHEN copero_counter <= 10 THEN 1 
				WHEN copero_counter > 10 AND copero_counter <=20 THEN 2
				ELSE 3
			END;
        SET sale_counter = 0;
        SET mod_dia = IF (DAYNAME(cur_date) = "Sunday" OR DAYNAME(cur_date) = "Saturday", 5, 0);
        SET sale_range = (FLOOR(RAND() * (30 - 7 + 1)) + 7) + mod_dia;
		WHILE sale_counter < sale_range DO
        
			SET horas = 
				CASE
					WHEN copero_counter % 2 = 0 THEN SEC_TO_TIME(46800 + RAND() * 14400)
					ELSE SEC_TO_TIME(32400 + RAND() * 14400)
				END;
			SET true_date = CONCAT(cur_date," ",horas);
			SET sale_counter = sale_counter + 1;
            
            INSERT INTO invoices (copero_id, payment_method, date, invoice_type, invoice_status, updated_at, computer, username, checksum)
			VALUE
				(copero_counter, "efectivo", true_date, "compra", "exitosa", true_date, "me", "root", sha2_var);
			SET last_insert_id_iv = LAST_INSERT_ID();
            SET rand_prod_id = FLOOR(RAND() * 10) + 1;
            SET rand_prod_quant = FLOOR(RAND() * 2) + 1;
            SELECT COALESCE(bp.price, pl.price)
			INTO price
			FROM beach_prices bp
			RIGHT JOIN price_logs pl ON bp.product_id = pl.product_id AND bp.beach_id = beach_id_
			WHERE pl.product_id = rand_prod_id;

			INSERT INTO orders (product_id, status, quantity, specific_location)
			VALUE
				(rand_prod_id, 1, rand_prod_quant, beach_id_);

			SET last_insert_id_od = LAST_INSERT_ID();

			INSERT INTO invoice_details (invoice_id, order_id, subtotal_cost, updated_at, created_at, computer, username, checksum)
			VALUE
				(last_insert_id_iv, last_insert_id_od, rand_prod_quant * price, true_date, true_date, "me", "root", sha2_var);
            UPDATE invoices iv
            INNER JOIN invoice_details ivd ON iv.invoice_id = ivd.invoice_id
            SET iv.total_cost = ivd.subtotal_cost, iv.total_paid = ivd.subtotal_cost
            WHERE iv.invoice_id = last_insert_id_iv;
            
            INSERT INTO inventories (car_id, ingredient_id, quantity, updated_at, created_at, operation_type)
            VALUE
				(CEILING(copero_counter/2), rand_prod_id, rand_prod_quant * 100, true_date, true_date, "venta");
			SET last_insert_id_inv = LAST_INSERT_ID();
            
            INSERT INTO inventory_checks (check_status_id, check_type_id, first_copero, second_copero, updated_at, created_at, computer, username, checksum, real_amount, inventory_id)
            VALUE
				(1, 1, copero_counter, NULL, true_date, true_date, "me", "root", sha2_var, rand_prod_quant * (100 + FLOOR(RAND() * 31)), last_insert_id_inv);
                
			INSERT INTO inventories (car_id, ingredient_id, quantity, updated_at, created_at, operation_type)
            VALUE
				(CEILING(copero_counter/2), 11, rand_prod_quant * 200, true_date, true_date, "venta");
			SET last_insert_id_inv = LAST_INSERT_ID();
            
            INSERT INTO inventory_checks (check_status_id, check_type_id, first_copero, second_copero, updated_at, created_at, computer, username, checksum, real_amount, inventory_id)
            VALUE
				(1, 1, copero_counter, NULL, true_date, true_date, "me", "root", sha2_var, rand_prod_quant * (200 + FLOOR(RAND() * 61)), last_insert_id_inv);
                
			INSERT INTO inventories (car_id, ingredient_id, quantity, updated_at, created_at, operation_type)
            VALUE
				(CEILING(copero_counter/2), 12, rand_prod_quant * 50, true_date, true_date);
			SET last_insert_id_inv = LAST_INSERT_ID();
            
            INSERT INTO inventory_checks (check_status_id, check_type_id, first_copero, second_copero, updated_at, created_at, computer, username, checksum, real_amount, inventory_id)
            VALUE
				(1, 1, copero_counter, NULL, true_date, true_date, "me", "root", sha2_var, rand_prod_quant * (50 + FLOOR(RAND() * 16)), last_insert_id_inv);
                
			INSERT INTO inventories (car_id, ingredient_id, quantity, updated_at, created_at, operation_type)
            VALUE
				(CEILING(copero_counter/2), 13, rand_prod_quant * 25, true_date, true_date, "venta");
			SET last_insert_id_inv = LAST_INSERT_ID();
            
            INSERT INTO inventory_checks (check_status_id, check_type_id, first_copero, second_copero, updated_at, created_at, computer, username, checksum, real_amount, inventory_id)
            VALUE
				(1, 1, copero_counter, NULL, true_date, true_date, "me", "root", sha2_var, rand_prod_quant * (25 + FLOOR(RAND() * 8)), last_insert_id_inv);
			
			INSERT INTO cashboxes (car_id, created_at, updated_at, operation_type, amount)
			VALUE
				(CEILING(copero_counter/2), true_date, true_date, "debito", rand_prod_quant * price);
			SET last_insert_id_cb = LAST_INSERT_ID();
			
			INSERT INTO cashbox_checks (check_status_id, check_type_id, first_copero, second_copero, updated_at, created_at, computer, username, checksum, real_amount, cashbox_id)
			VALUES
				(1, 1, copero_counter, NULL, true_date, true_date, "me", "root", sha2_var, rand_prod_quant * price, last_insert_id_cb);
		END WHILE;
	END WHILE;
  END WHILE;
    
END //
DELIMITER ;