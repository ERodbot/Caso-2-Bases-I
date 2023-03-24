
DROP PROCEDURE IF EXISTS `transactional_sales_fill`;

DELIMITER $$;

CREATE PROCEDURE `transactional_sales_fill`(

	IN pProductGroup VARCHAR(36),
    IN pProductName VARCHAR(45),
    IN pQuantity VARCHAR(45)

)


BEGIN 

    -- Defining the action ougth to be taken in case of transaction failure 

    DECLARE EROR_CONSTANT_NAME INT DEFAULT 53000;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN 
        GET DIAGNOSTICS CONDITION 1 @err_no = MYSQL_ERRNO, @message = MESSAGE_TEXT;
        IF (ISNULL(@message)) THEN
            SET @message = "ninguno";
        ELSE 
            SET @message = CONCAT("Internal Error ", @message);
        END IF;
        ROLLBACK;
        RESIGNAL SET MESSAGE_TEXT = @message;
    END;

    -- Declaration of variables for different validations. 

    DECLARE val_coperoId INT;
    DECLARE val_location VARCHAR(50);
    DECLARE val_productId INT;
    DECLARE val_invoiceId INT;
    DECLARE val_quantity BIGINT;
    DECLARE last_insert_id INT DEFAULT NULL;
	DECLARE price DECIMAL(10,2);
  
    -- Validation values extracted for the inserted values for the transaction. 
    
   
	SELECT IFNULL(copero_id,-1) INTO val_coperoId FROM coperos WHERE copero_id = tmpSaleData.copero_id;
	SELECT IFNULL(location,'invalid') INTO val_location FROM beaches WHERE beach_id = tmpSaleData.t_location;
    SELECT IFNULL(product_id,-1) INTO val_productId FROM products WHERE description = pProductName;
    SELECT IFNULL(invoice_id,-1) INTO val_invoiceId FROM invoices WHERE invoice_id = tmpSaleData.invoice_id;
    SELECT SUM(CASE WHEN val_productId <> -1 AND inventories.product_id = val_productId THEN inventories.quantity ELSE 0 END) INTO val_quantity;
    
    
    
    -- Validation for said values (a error message is triggered in case of invalidity)
    
    IF (val_quantity <= 0 OR val_location <= 0 OR val_coperoId <= 0) THEN
        SIGNAL SQLSTATE '53001' SET MYSQL_ERRNO = EROR_CONSTANT_NAME;
    END IF;
	IF (val_quantity <= pQuantity) THEN
        SIGNAL SQLSTATE '53002' SET MYSQL_ERRNO = EROR_CONSTANT_NAME;
    END IF;
    IF (coperoId = -1) THEN
		SIGNAL SQLSTATE '53006' SET MYSQL_ERRNO = EROR_CONSTANT_NAME;
	END IF;

	IF (location = 'invalid') THEN
		SIGNAL SQLSTATE '53007' SET MYSQL_ERRNO = EROR_CONSTANT_NAME;
	END IF;

	IF (productId = -1) THEN
		SIGNAL SQLSTATE '53008' SET MYSQL_ERRNO = EROR_CONSTANT_NAME;
	END IF;

	IF (invoiceId = -1) THEN
		SIGNAL SQLSTATE '53009' SET MYSQL_ERRNO = EROR_CONSTANT_NAME;
	END IF;

    SET autocommit = 0;

		

	-- Everything cool!
    -- Transaction beggins:

    START TRANSACTION;

    INSERT INTO invoices (copero_id, payment_method, date, invoice_type, invoice_status, updated_at, computer, username, checksum)
        SELECT val_copero_id, tsd.payment_method, curdate(), tsd.invoice_type, "existosa", curdate(), "me", "root", SHA2("password",256)
        FROM tmpSaleData tsd
        WHERE inventorygroup = p_inventory_group;
    
    
    SELECT COALESCE(bp.price, pl.price)
    INTO price
    FROM beach_prices bp
    RIGHT JOIN price_logs pl ON bp.product_id = pl.product_id AND bp.beach_id = t_location
    WHERE pl.product_id = t_product_id;

    INSERT INTO orders (product_id, status, quantity, specific_location)
		SELECT val_product_id, 1, pQuantity, val_location;

    SET last_insert_id = LAST_INSERT_ID;

    INSERT INTO invoice_details (invoice_id, order_id, subtotal_cost, updated_at, created_at, computer, username, checksum)
    VALUES
        (tsd.invoice_id, last_insert_id, pQuantity * price, curdate(), curdate, "me", "root", SHA2("password", 256));


	INSERT INTO inventories (car_id, ingredient_id, quantity, updated_at, created_at, operation_type)
            VALUES
				(val_copero_id, val_product_id, pQuantity, curdate(), curdate(), "venta");
			SET last_insert_id_inv = LAST_INSERT_ID();
            
	COMMIT
    
END$$




CREATE TABLE tmpSaleData
(
	saleGroup VARCHAR(36),
	product_id INT,
    invoice_id INT,
    name INT,
    copero_id INT,
    payment_method VARCHAR(10),
    invoice_type VARCHAR(10)
);


INSERT INTO tmpInventoryData (saleGroup, product_id, invoice_id, name, copero_id, payment_method, invoice_type) 
VALUES
	(@migrupo, 1, 12124, 1, 'Tamarindo', 'efectivo', 'venta'),  
	(@migrupo, 1, 12125, 2, 'Hermosa', 'efectivo', 'venta'),
	(@migrupo, 1, 12126, 1, 'Tamarindo', 'efectivo', 'venta');

call transactional_sales_fill(@migrupo, "Copo Rojo", 1);



