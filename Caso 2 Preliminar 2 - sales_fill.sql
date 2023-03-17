DELIMITER //}
DROP PROCEDURE IF EXISTS `sales_fill`;
CREATE PROCEDURE `sales_fill` ()
BEGIN

  DECLARE cur_date DATE;
  SET cur_date = '2023-03-15';
  DECLARE sale_counter INT DEFAULT 1;
  DECLARE sale_range INT DEFAULT 1;
  DECLARE car_counter INT DEFAULT 1;
  DECLARE iv_id INT;
  DECLARE beach_id INT;
	
  WHILE cur_date <= '2023-4-23' DO
	SET copero_counter = 1;
 	WHILE copero_counter < 30 DO
		CASE 
			WHEN copero_counter <= 10 THEN beach_id = 1
			WHEN copero_counter > 10 AND copero_counter <=20 THEN beach_id = 2
			ELSE beach_id = 3
		END
        SET sale_counter = 1;
        SET sale_range = FLOOR(RAND() * (30 - 7 + 1)) + 7;
		WHILE sale_counter <= sale_range DO
			CALL `invoice`(copero_counter, cur_date,"efectivo", "compra", iv_id)
			CALL `order`(FLOOR(RAND() * 10) + 1, FLOOR(RAND() * 3) + 1, cur_date, iv_id, beach_id)
            
            -- INVOICES
            -- update al cost
            -- update al paid
            -- update al change
            
            
            SET sale_counter = sale_counter + 1;
		END WHILE;
		SET copero_counter = copero_counter + 1;
	END WHILE;
	SET cur_date = DATE_ADD(cur_date, INTERVAL 1 DAY);
  END WHILE;
    
END //
DELIMITER ;