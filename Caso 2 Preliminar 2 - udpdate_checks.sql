UPDATE inventory_checks INNER JOIN inventories ON inventory_checks.inventory_id = inventories.inventory_id
SET 
inventory_checks.check_status_id =
	CASE 
		WHEN inventory_checks.real_amount > (inventories.quantity + inventories.quantity * 0.25) THEN 3
		ELSE 2
	END,
inventory_checks.second_copero =
	CASE
		WHEN inventory_checks.first_copero % 2 = 0 THEN inventory_checks.first_copero - 1
		ELSE inventory_checks.first_copero + 1
	END,
inventory_checks.updated_at =
	CASE
		WHEN inventory_checks.first_copero % 2 = 0 THEN CONCAT(DATE(inventory_checks.updated_at)," ","09:00:00" )
		ELSE CONCAT(DATE(inventory_checks.updated_at)," ","13:00:00" )
	END
WHERE inventory_checks.check_type_id = 1;

UPDATE cashbox_checks cbc INNER JOIN cashboxes cb ON cbc.cashbox_id = cb.cashbox_id
SET 
cbc.check_status_id =
	CASE 
		WHEN cbc.real_amount > (cb.amount + cb.amount * 0.25) THEN 3
		ELSE 2
	END,
cbc.second_copero =
	CASE
		WHEN cbc.first_copero % 2 = 0 THEN cbc.first_copero - 1
		ELSE cbc.first_copero + 1
	END,
cbc.updated_at =
	CASE
		WHEN cbc.first_copero % 2 = 0 THEN CONCAT(DATE(cbc.updated_at)," ","09:00:00" )
		ELSE CONCAT(DATE(cbc.updated_at)," ","13:00:00" )
	END
WHERE cbc.check_status_id = 1;