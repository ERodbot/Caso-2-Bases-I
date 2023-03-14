DELIMITER //
CREATE PROCEDURE `data_fill` ()
BEGIN
	DECLARE bc_counter INT DEFAULT 1;
    DECLARE car_counter INT DEFAULT 1;
    DECLARE ipp_counter INT DEFAULT 1;
    DECLARE bp_counter INT DEFAULT 1;
    DECLARE name_select varchar(10);
	DECLARE car_color VARCHAR(10);
    
    CREATE TEMPORARY TABLE names(
		name_id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(10)
	);
	INSERT INTO names
    VALUES 
		("Sean"),("Rocco"),("Brooklyn"),("Robbie"),("Julius"),("Clyde"),("Walter"),("Maison"),
        ("Zain"),("Garfield"),("Kajus"),("Joel"),("Emilio"),("Kaylum"),("Olly"),("Eesa"),
        ("Stephen"),("Ilyas"),("Sian"),("Yash"),("Aaryan"),("Mohamad"),("Tommy"),("Tomas"),
		("Jimmy"),("Ray"),("Mohamed"),("Everly"),("Tariq"),("Frances");
        
	CREATE TEMPORARY TABLE colors(
		color_id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(10)
	);
	INSERT INTO colors
    VALUES 
		("rojo"),("azul"),("amarillo"),("verde"),("rosado"),("naranja"),("morado"),("negro"),
        ("blanco"),("celeste");
        
	WHILE bc_counter <=30 DO
		INSERT INTO bank_accounts
		VALUE
			(bc_counter, bc_counter*10, GETDATE(), GETDATE(), "me", "root", SHA2(" ",150));
        
		SELECT name INTO name_select FROM names WHERE name_id = bc_counter;
        
		INSERT INTO coperos
		VALUE
			(bc_counter, bc_counter,name_select, FLOOR(RAND() * (99999999 - 10000000 + 1) + 10000000), 1, GETDATE(), GETDATE(), "me", "root", SHA2(" ",150));
            
		SET bc_counter = bc_counter + 1;
        
	END WHILE;
        
        INSERT INTO beaches
        VALUES
			(1, "Tamarindo", GETDATE()),(2, "Samara", GETDATE()),(3, "Hermosa", GETDATE());
            
		INSERT INTO products
        VALUES
			(1, "Copo Rojo", 1, GETDATE(), GETDATE(), "me", "root", SHA2(" ",150)),
            (2, "Copo Verde", 1, GETDATE(), GETDATE(), "me", "root", SHA2(" ",150)),
            (3, "Copo Rosado", 1, GETDATE(), GETDATE(), "me", "root", SHA2(" ",150)),
            (4, "Copo Azul", 1, GETDATE(), GETDATE(), "me", "root", SHA2(" ",150)),
            (5, "Copo Naranja", 1, GETDATE(), GETDATE(), "me", "root", SHA2(" ",150)),
            (6, "Copo Amarillo", 1, GETDATE(), GETDATE(), "me", "root", SHA2(" ",150)),
            (7, "Copo Coco", 1, GETDATE(), GETDATE(), "me", "root", SHA2(" ",150)),
            (8, "Copo Ron", 1, GETDATE(), GETDATE(), "me", "root", SHA2(" ",150)),
            (9, "Copo Vodka", 1, GETDATE(), GETDATE(), "me", "root", SHA2(" ",150)),
            (10, "Copo Cacique", 1, GETDATE(), GETDATE(), "me", "root", SHA2(" ",150));
            
		INSERT INTO ingredients
        VALUES   
            (1, "Sirope Rojo", "ml", 1, GETDATE(), GETDATE()),
            (2, "Sirope Verde", "ml", 1, GETDATE(), GETDATE()),
            (3, "Sirope Rosado", "ml", 1, GETDATE(), GETDATE()),
            (4, "Sirope Azul", "ml", 1, GETDATE(), GETDATE()),
            (5, "Sirope Naranja", "ml", 1, GETDATE(), GETDATE()),
            (6, "Sirope Amarillo", "ml", 1, GETDATE(), GETDATE()),
            (7, "Sirope Coco", "ml", 1, GETDATE(), GETDATE()),
            (8, "Ron", "ml", 1, GETDATE(), GETDATE()),
            (9, "Vodka", "ml", 1, GETDATE(), GETDATE()),
            (10, "Cacique", "ml", 1, GETDATE(), GETDATE()),
			(11, "Hielo", "g", 1, GETDATE(), GETDATE()),
            (12, "Leche Pinito", "g", 1, GETDATE(), GETDATE()),
            (13, "Leche Condensada", "ml", 1, GETDATE(), GETDATE());
            
	WHILE ipp_counter <=10 DO
		INSERT INTO ingredients_per_product
		VALUES
			(ipp_counter, ipp_counter, 250, GETDATE(), GETDATE(), "me", "root", SHA2(" ",150)),
			(ipp_counter,11, 500, GETDATE(), GETDATE(), "me", "root", SHA2(" ",150)),
			(ipp_counter,12, 100, GETDATE(), GETDATE(), "me", "root", SHA2(" ",150)),
			(ipp_counter,13, 50, GETDATE(), GETDATE(), "me", "root", SHA2(" ",150));
                
		INSERT INTO price_logs
		VALUES
			(ipp_counter, 2000, ipp_counter, GETDATE(), "2023-04-16 11:45:00.000", GETDATE(), GETDATE(), "me", "root", SHA2(" ",150));
                
	END WHILE;
        
	WHILE bp_counter <=3 DO
		INSERT INTO beach_prices
		VALUES
			(bp_counter, GETDATE(), "2023-04-16 11:45:00.000", 3000, bp_counter, 8, GETDATE(), GETDATE(), "me", "root", SHA2(" ",150)),
			(bp_counter, GETDATE(), "2023-04-16 11:45:00.000", 3500, bp_counter, 9, GETDATE(), GETDATE(), "me", "root", SHA2(" ",150)),
			(bp_counter, GETDATE(), "2023-04-16 11:45:00.000", 2500, bp_counter, 10, GETDATE(), GETDATE(), "me", "root", SHA2(" ",150));
	END WHILE;
        
	WHILE car_counter <=15 DO
		SELECT name INTO car_color FROM colors WHERE color_id = (FLOOR(RAND() * 10) + 1);
    
		INSERT INTO cars
		VALUE
			(car_counter, car_color, 1, GETDATE(), GETDATE());
        
		SET car_counter = car_counter + 1;
        
	END WHILE;
		
        
		
END //
DELIMITER ;