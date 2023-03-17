DELIMITER //
DROP PROCEDURE IF EXISTS `sales_fill`;
CREATE PROCEDURE `sales_fill` ()
BEGIN

  DECLARE cur_date DATE;
  DECLARE sale_counter INT DEFAULT 0;
  DECLARE sale_range INT DEFAULT 0;
  DECLARE copero_counter INT DEFAULT 0;
  DECLARE iv_id INT;
  DECLARE beach_id INT;
  SET cur_date = '2023-03-14';

  WHILE cur_date < '2023-9-15' DO
	SET cur_date = DATE_ADD(cur_date, INTERVAL 1 DAY);
	SET copero_counter = 0;
 	WHILE copero_counter < 30 DO
		SET copero_counter = copero_counter + 1;
		SET beach_id =
			CASE 
				WHEN copero_counter <= 10 THEN 1
				WHEN copero_counter > 10 AND copero_counter <=20 THEN 2
				ELSE 3
			END;
        SET sale_counter = 0;
        SET sale_range = FLOOR(RAND() * (30 - 7 + 1)) + 7;
		WHILE sale_counter < sale_range DO
			SET sale_counter = sale_counter + 1;
			CALL `invoice`(copero_counter, cur_date, "efectivo", "compra", iv_id);
			CALL `order`(FLOOR(RAND() * 10) + 1, FLOOR(RAND() * 2) + 1, cur_date, iv_id, beach_id);
            
            UPDATE invoices iv
            INNER JOIN invoice_details ivd ON iv.invoice_id = ivd.invoice_id
            SET iv.total_cost = ivd.subtotal_cost, iv.total_paid = ivd.subtotal_cost
            WHERE iv.invoice_id = iv_id;
            
		END WHILE;
	END WHILE;
  END WHILE;
    
END //
DELIMITER ;