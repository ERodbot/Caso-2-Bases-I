DELIMITER //
DROP PROCEDURE IF EXISTS `invoice`;
CREATE PROCEDURE `invoice` (IN t_copero_id INT, IN t_date DATETIME, IN t_payment_method VARCHAR(10), IN t_invoice_type VARCHAR(10), OUT last_insert_id INT)
BEGIN
INSERT INTO invoices (copero_id, payment_method, date, invoice_type, invoice_status, updated_at, computer, username, checksum)
VALUE
	(t_copero_id, t_payment_method, t_date, t_invoice_type, "exitosa", t_date, "me", "root", SHA2("password",256));
SET last_insert_id = LAST_INSERT_ID();
END //
DELIMITER ;