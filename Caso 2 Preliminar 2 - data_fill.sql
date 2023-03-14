DELIMITER //
CREATE PROCEDURE `data_fill` ()
BEGIN
	DECLARE bc_counter INT DEFAULT 1;
    DECLARE car_counter INT DEFAULT 1;
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
    
	WHILE car_counter <=15 DO
		SELECT name INTO car_color FROM colors WHERE color_id = (FLOOR(RAND() * 10) + 1);
    
		INSERT INTO cars
		VALUE
			(car_counter, car_color, 1, GETDATE(), GETDATE());
        
		SET car_counter = car_counter + 1;
        
		END WHILE;
END //
DELIMITER ;