DELIMITER //
DROP PROCEDURE IF EXISTS schedule_maker;
CREATE PROCEDURE `schedule_maker` ()
BEGIN
  DECLARE cur_date DATE;
  SET cur_date = '2023-03-15';

  WHILE cur_date <= '2023-09-23' DO
    INSERT INTO schedules (copero_id, carrito_id, playa_id, pickup_date, dropoff_date, pickup_location, dropoff_location, updated_at, created_at, computer, username, checksum)
    VALUES
		(1, 1, 1, CONCAT(cur_date, " 09:00:00"), CONCAT(cur_date, " 13:00:00"), "Tamarindo", "Tamarindo", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (2, 1, 1, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 17:00:00"), "Tamarindo", "Tamarindo", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (3, 2, 1, CONCAT(cur_date, " 09:00:00"), CONCAT(cur_date, " 13:00:00"), "Tamarindo", "Tamarindo", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (4, 2, 1, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 17:00:00"), "Tamarindo", "Tamarindo", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (5, 3, 1, CONCAT(cur_date, " 09:00:00"), CONCAT(cur_date, " 13:00:00"), "Tamarindo", "Tamarindo", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (6, 3, 1, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 17:00:00"), "Tamarindo", "Tamarindo", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (7, 4, 1, CONCAT(cur_date, " 09:00:00"), CONCAT(cur_date, " 13:00:00"), "Tamarindo", "Tamarindo", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (8, 4, 1, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 17:00:00"), "Tamarindo", "Tamarindo", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (9, 5, 1, CONCAT(cur_date, " 09:00:00"), CONCAT(cur_date, " 13:00:00"), "Tamarindo", "Tamarindo", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (10, 5, 1, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 17:00:00"), "Tamarindo", "Tamarindo", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (11, 6, 2, CONCAT(cur_date, " 09:00:00"), CONCAT(cur_date, " 13:00:00"), "Samara", "Samara", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (12, 6, 2, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 17:00:00"), "Samara", "Samara", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (13, 7, 2, CONCAT(cur_date, " 09:00:00"), CONCAT(cur_date, " 13:00:00"), "Samara", "Samara", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (14, 7, 2, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 17:00:00"), "Samara", "Samara", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (15, 8, 2, CONCAT(cur_date, " 09:00:00"), CONCAT(cur_date, " 13:00:00"), "Samara", "Samara", cur_date, cur_date, "me", "root", SHA2("password",256)),
		(16, 8, 2, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 17:00:00"), "Samara", "Samara", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (17, 9, 2, CONCAT(cur_date, " 09:00:00"), CONCAT(cur_date, " 13:00:00"), "Samara", "Samara", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (18, 9, 2, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 17:00:00"), "Samara", "Samara", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (19, 10, 2, CONCAT(cur_date, " 09:00:00"), CONCAT(cur_date, " 13:00:00"), "Samara", "Samara", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (20, 10, 2, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 17:00:00"), "Samara", "Samara", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (21, 11, 3, CONCAT(cur_date, " 09:00:00"), CONCAT(cur_date, " 13:00:00"), "Hermosa", "Hermosa", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (22, 11, 3, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 17:00:00"), "Hermosa", "Hermosa", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (23, 12, 3, CONCAT(cur_date, " 09:00:00"), CONCAT(cur_date, " 13:00:00"), "Hermosa", "Hermosa", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (24, 12, 3, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 17:00:00"), "Hermosa", "Hermosa", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (25, 13, 3, CONCAT(cur_date, " 09:00:00"), CONCAT(cur_date, " 13:00:00"), "Hermosa", "Hermosa", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (26, 13, 3, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 17:00:00"), "Hermosa", "Hermosa", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (27, 14, 3, CONCAT(cur_date, " 09:00:00"), CONCAT(cur_date, " 13:00:00"), "Hermosa", "Hermosa", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (28, 14, 3, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 17:00:00"), "Hermosa", "Hermosa", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (29, 15, 3, CONCAT(cur_date, " 09:00:00"), CONCAT(cur_date, " 13:00:00"), "Hermosa", "Hermosa", cur_date, cur_date, "me", "root", SHA2("password",256)),
        (30, 15, 3, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 17:00:00"), "Hermosa", "Hermosa", cur_date, cur_date, "me", "root", SHA2("password",256));
	INSERT INTO inventory_checks (check_status_id, check_type_id, first_copero, second_copero, updated_at, created_at, computer, username, checksum)
    VALUES
		(2, 1, 1, 2, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 13:00:00"), "me", "root", SHA2("password",256)),
        (2, 1, 3, 4, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 13:00:00"), "me", "root", SHA2("password",256)),
        (2, 1, 5, 6, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 13:00:00"), "me", "root", SHA2("password",256)),
        (2, 1, 7, 8, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 13:00:00"), "me", "root", SHA2("password",256)),
        (2, 1, 9, 10, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 13:00:00"), "me", "root", SHA2("password",256)),
        (2, 1, 11, 12, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 13:00:00"), "me", "root", SHA2("password",256)),
        (2, 1, 13, 14, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 13:00:00"), "me", "root", SHA2("password",256)),
        (2, 1, 15, 16, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 13:00:00"), "me", "root", SHA2("password",256)),
        (2, 1, 17, 18, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 13:00:00"), "me", "root", SHA2("password",256)),
        (2, 1, 19, 20, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 13:00:00"), "me", "root", SHA2("password",256)),
        (2, 1, 21, 22, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 13:00:00"), "me", "root", SHA2("password",256)),
        (2, 1, 23, 24, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 13:00:00"), "me", "root", SHA2("password",256)),
        (2, 1, 25, 26, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 13:00:00"), "me", "root", SHA2("password",256)),
        (3, 1, 27, 28, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 13:00:00"), "me", "root", SHA2("password",256)),
        (3, 1, 29, 30, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 13:00:00"), "me", "root", SHA2("password",256));
        
	INSERT INTO cashbox_checks (check_status_id, check_type_id, first_copero, second_copero, updated_at, created_at, computer, username, checksum)
    VALUES
		(3, 1, 1, 2, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 13:00:00"), "me", "root", SHA2("password",256)),
        (3, 1, 3, 4, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 13:00:00"), "me", "root", SHA2("password",256)),
        (2, 1, 5, 6, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 13:00:00"), "me", "root", SHA2("password",256)),
        (2, 1, 7, 8, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 13:00:00"), "me", "root", SHA2("password",256)),
        (2, 1, 9, 10, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 13:00:00"), "me", "root", SHA2("password",256)),
        (2, 1, 11, 12, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 13:00:00"), "me", "root", SHA2("password",256)),
        (2, 1, 13, 14, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 13:00:00"), "me", "root", SHA2("password",256)),
        (2, 1, 15, 16, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 13:00:00"), "me", "root", SHA2("password",256)),
        (2, 1, 17, 18, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 13:00:00"), "me", "root", SHA2("password",256)),
        (2, 1, 19, 20, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 13:00:00"), "me", "root", SHA2("password",256)),
        (2, 1, 21, 22, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 13:00:00"), "me", "root", SHA2("password",256)),
        (2, 1, 23, 24, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 13:00:00"), "me", "root", SHA2("password",256)),
        (2, 1, 25, 26, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 13:00:00"), "me", "root", SHA2("password",256)),
        (2, 1, 27, 28, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 13:00:00"), "me", "root", SHA2("password",256)),
        (2, 1, 29, 30, CONCAT(cur_date, " 13:00:00"), CONCAT(cur_date, " 13:00:00"), "me", "root", SHA2("password",256));
        
    SET cur_date = DATE_ADD(cur_date, INTERVAL 1 DAY);
  END WHILE;
  
END //
DELIMITER ;