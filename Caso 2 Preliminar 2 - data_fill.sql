DELIMITER //
DROP PROCEDURE IF EXISTS data_fill;
CREATE PROCEDURE `data_fill` ()
BEGIN
	DECLARE bc_counter INT DEFAULT 1;
    DECLARE ipp_counter INT DEFAULT 1;
    DECLARE name_select varchar(10);
    
    DROP TABLE IF EXISTS names;
    CREATE TEMPORARY TABLE names(
		name_id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(10)
	);
	INSERT INTO names
    VALUES 
		(1, "Sean"),(2, "Rocco"),(3, "Brooklyn"),(4, "Robbie"),(5, "Julius"),(6, "Clyde"),(7, "Walter"),(8, "Maison"),
        (9, "Zain"),(10, "Garfield"),(11, "Kajus"),(12, "Joel"),(13, "Emilio"),(14, "Kaylum"),(15, "Olly"),(16, "Eesa"),
        (17, "Stephen"),(18, "Ilyas"),(19, "Sian"),(20, "Yash"),(21, "Aaryan"),(22, "Mohamad"),(23, "Tommy"),(24, "Tomas"),
		(25, "Jimmy"),(26, "Ray"),(27, "Mohamed"),(28, "Everly"),(29, "Tariq"),(30, "Frances");
        
	WHILE bc_counter <=30 DO
		INSERT INTO bank_accounts
		VALUE
			(bc_counter, bc_counter*10, CURDATE(), CURDATE(), "me", "root", SHA2("password",256));
        
		SELECT name INTO name_select FROM names WHERE name_id = bc_counter;
        
		INSERT INTO coperos
		VALUE
			(bc_counter, bc_counter, name_select, FLOOR(RAND() * (99999999 - 10000000 + 1) + 10000000), 1, CURDATE(), CURDATE(), "me", "root", SHA2("password",256));
            
		SET bc_counter = bc_counter + 1;
	END WHILE;
        
	INSERT INTO beaches
	VALUES
		(1, "Tamarindo", CURDATE()),(2, "Samara", CURDATE()),(3, "Hermosa", CURDATE());
            
	INSERT INTO products
	VALUES
		(1, "Copo Rojo", 1, CURDATE(), CURDATE(), "me", "root", SHA2("password",256)),
		(2, "Copo Verde", 1, CURDATE(), CURDATE(), "me", "root", SHA2("password",256)),
		(3, "Copo Rosado", 1, CURDATE(), CURDATE(), "me", "root", SHA2("password",256)),
		(4, "Copo Azul", 1, CURDATE(), CURDATE(), "me", "root", SHA2("password",256)),
		(5, "Copo Naranja", 1, CURDATE(), CURDATE(), "me", "root", SHA2("password",256)),
		(6, "Copo Amarillo", 1, CURDATE(), CURDATE(), "me", "root", SHA2("password",256)),
		(7, "Copo Coco", 1, CURDATE(), CURDATE(), "me", "root", SHA2("password",256)),
		(8, "Copo Ron", 1, CURDATE(), CURDATE(), "me", "root", SHA2("password",256)),
		(9, "Copo Vodka", 1, CURDATE(), CURDATE(), "me", "root", SHA2("password",256)),
		(10, "Copo Cacique", 1, CURDATE(), CURDATE(), "me", "root", SHA2("password",256));
            
	INSERT INTO ingredients
	VALUES   
		(1, "Sirope Rojo", "ml", 1, CURDATE(), CURDATE()),
		(2, "Sirope Verde", "ml", 1, CURDATE(), CURDATE()),
		(3, "Sirope Rosado", "ml", 1, CURDATE(), CURDATE()),
		(4, "Sirope Azul", "ml", 1, CURDATE(), CURDATE()),
		(5, "Sirope Naranja", "ml", 1, CURDATE(), CURDATE()),
		(6, "Sirope Amarillo", "ml", 1, CURDATE(), CURDATE()),
		(7, "Sirope Coco", "ml", 1, CURDATE(), CURDATE()),
		(8, "Ron", "ml", 1, CURDATE(), CURDATE()),
		(9, "Vodka", "ml", 1, CURDATE(), CURDATE()),
		(10, "Cacique", "ml", 1, CURDATE(), CURDATE()),
		(11, "Hielo", "g", 1, CURDATE(), CURDATE()),
		(12, "Leche Pinito", "g", 1, CURDATE(), CURDATE()),
		(13, "Leche Condensada", "ml", 1, CURDATE(), CURDATE());
            
	WHILE ipp_counter <=10 DO
		INSERT INTO ingredients_per_products
		VALUES
			(ipp_counter, ipp_counter, 100, CURDATE(), CURDATE(), "me", "root", SHA2("password",256)),
			(ipp_counter,11, 200, CURDATE(), CURDATE(), "me", "root", SHA2("password",256)),
			(ipp_counter,12, 50, CURDATE(), CURDATE(), "me", "root", SHA2("password",256)),
			(ipp_counter,13, 25, CURDATE(), CURDATE(), "me", "root", SHA2("password",256));
                
		INSERT INTO price_logs
		VALUES
			(ipp_counter, 2000.00, ipp_counter,"2023-03-15 00:00:00", "2023-09-16 11:45:00", CURDATE(), CURDATE(), "me", "root", SHA2("password",256));
		
        SET ipp_counter = ipp_counter + 1;
	END WHILE;
    
	INSERT INTO cars
	VALUES
		(1, "verde", 1, CURDATE(), CURDATE()),
        (2, "azul", 1, CURDATE(), CURDATE()),
        (3, "naranja", 1, CURDATE(), CURDATE()),
        (4, "morado", 1, CURDATE(), CURDATE()),
        (5, "rojo", 1, CURDATE(), CURDATE()),
        (6, "rosado", 1, CURDATE(), CURDATE()),
        (7, "violeta", 1, CURDATE(), CURDATE()),
        (8, "negro", 1, CURDATE(), CURDATE()),
        (9, "blanco", 1, CURDATE(), CURDATE()),
        (10, "gris", 1, CURDATE(), CURDATE()),
        (11, "amarillo", 1, CURDATE(), CURDATE()),
        (12, "cafe", 1, CURDATE(), CURDATE()),
        (13, "celeste", 1, CURDATE(), CURDATE()),
        (14, "crema", 1, CURDATE(), CURDATE()),
        (15, "dorado", 1, CURDATE(), CURDATE());

	INSERT INTO beach_prices
	VALUES
		(1, "2023-03-15 00:00:00", "2023-09-16 11:45:00", 3000.00, 1, 8, CURDATE(), CURDATE(), "me", "root", SHA2("password",256)),
		(2, "2023-03-15 00:00:00", "2023-09-16 11:45:00", 3500.00, 2, 9, CURDATE(), CURDATE(), "me", "root", SHA2("password",256)),
		(3, "2023-03-15 00:00:00", "2023-09-16 11:45:00", 2500.00, 3, 10, CURDATE(), CURDATE(), "me", "root", SHA2("password",256));
	INSERT INTO check_statuses
    VALUES 
		(1, "pendiente"),
        (2, "correcto"),
        (3, "diferencias");
	
    INSERT INTO check_types
    VALUES 
		(1, "cambio"),
        (2, "inicio");
        
	INSERT INTO commissions
    VALUES
		(1, 0.10, "2023-03-15 00:00:00", "2023-06-15 00:00:00", 1, SHA2("password",256), CURDATE(), CURDATE(), "me", "root"),
        (2, 0.12, "2023-06-16 00:00:00", "2023-09-17 00:00:00", 1, SHA2("password",256), CURDATE(), CURDATE(), "me", "root");
	
END //
DELIMITER ;