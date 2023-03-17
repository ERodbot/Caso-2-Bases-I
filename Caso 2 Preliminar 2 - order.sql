DELIMITER //
DROP PROCEDURE IF EXISTS `order`;
CREATE PROCEDURE `order` (IN t_product_id INT, IN t_quantity INT, IN t_date DATETIME, IN t_invoice_id INT, IN t_location INT)
BEGIN

DECLARE last_insert_id INT;
DECLARE price DECIMAL(10,2);


SELECT COALESCE(bp.price, pl.price)
INTO price
FROM beach_prices bp
RIGHT JOIN price_logs pl ON bp.product_id = pl.product_id AND bp.beach_id = t_location
WHERE pl.product_id = t_product_id;

INSERT INTO orders (product_id, status, quantity, specific_location)
VALUE
	(t_product_id, 1, t_quantity, t_location);

SET last_insert_id = LAST_INSERT_ID();

INSERT INTO invoice_details (invoice_id, order_id, subtotal_cost, updated_at, created_at, computer, username, checksum)
VALUE
	(t_invoice_id, last_insert_id(), t_quantity * price, t_date, t_date, "me", "root", SHA2("password",256));
    
END //
DELIMITER ;