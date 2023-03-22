USE Copos;

SET @startingDate = '2023-03-18';
SET @endDate = '2023-03-20';

SELECT 
	ing.description,
    @startingDate AS startingDate,
    @endDate AS endDate,
    SUM(CASE WHEN inv.operation_type = 'refill' THEN inv.quantity ELSE 0 END) AS refill_total,
    SUM(CASE WHEN inv.operation_type = 'venta' THEN inv.quantity ELSE 0 END) AS sale_total,
    SUM(CASE WHEN inv.operation_type = 'refill' THEN inv.quantity ELSE -inv.quantity END) AS refill_sale_difference,
    SUM(inv.quantity) AS quantity, 
    ing.measurement
FROM inventories inv 
INNER JOIN ingredients ing ON inv.ingredient_id = ing.ingredient_id
WHERE inv.created_at BETWEEN @startingDate AND @endDate 
GROUP BY ing.description, ing.measurement;



SELECT 
	@startingDate AS startingDate,
    @endDate AS endDate,
	SUM(IFNULL(ivoices.total_cost, 0)) AS cost, 
    SUM(IFNULL(ivoices.total_change, 0)) AS total_change,
    SUM(IFNULL(ivoices.total_cost, 0) - IFNULL(ivoices.total_change, 0)) AS cost_change_difference,
    SUM(copPay.payday) AS total_payment,
    cop.name AS copero
FROM coperos cop 
INNER JOIN invoices ivoices ON ivoices.copero_id = cop.copero_id
INNER JOIN copero_payments copPay ON ivoices.invoice_id = copPay.invoice_id
GROUP BY cop.name;


DROP VIEW IF EXISTS VW_ConsistencyCheck;
CREATE VIEW VW_ConsistencyCheck AS
SELECT 
    sch.pickup_date,
    sch.dropoff_date,
    beach.name,
    cop.name,
    car.color,
    ing.description,
    ing.measurement,
    iv_check.real_amount,
    SUM(CASE WHEN inventories.created_at = sch.pickup_date AND inventories.car_id = sch.carrito_id THEN inventories.quantity ELSE 0 END)
FROM schedules sch 
INNER JOIN beaches beach ON sch.playa_id = beach.beach_id
INNER JOIN inventory_checks iv_check ON  iv_check.inventory_id = inventories.inventory_id
INNER JOIN ingredients ing ON ing.ingredient_id = inventories.ingredient_id
INNER JOIN coperos cop ON cop.copero_id = sch.carrito_id
INNER JOIN cars car ON car.car_id = sch.car_id
WHERE sch.pickup_date BETWEEN '2023-03-16' AND '2023-03-20'
GROUP BY sch.pickup_date, sch.dropoff_date, beach.name;


	
    
DROP VIEW IF EXISTS VW_Schedule;

CREATE VIEW VW_integrityCheck AS

SELECT
	sch.pickup_date,
	sch.dropoff_date,
	beach.name AS beach,
	cop.name,
	car.color,
    ing.description, 
    iv_check.real_amount AS expectedAmount,
    SUM(iv.quantity) AS inventoryStock,
	CASE 
        WHEN check_s.status_name = "correcto"  THEN 'clean' 
		WHEN check_s.status_name = "pendiente" THEN "pending"
        ELSE 'inconsistency'
	END AS check_status
FROM schedules sch
	INNER JOIN beaches beach ON sch.playa_id = beach.beach_id
	INNER JOIN coperos cop ON cop.copero_id = sch.copero_id
	INNER JOIN cars car ON car.car_id = sch.carrito_id
    INNER JOIN inventory_checks iv_check ON iv_check.first_copero = cop.copero_id
	INNER JOIN inventories iv  ON iv.inventory_id = iv_check.inventory_id
    INNER JOIN ingredients ing ON ing.ingredient_id = iv.ingredient_id
    INNER JOIN check_statuses check_s ON check_s.check_status_id = iv_check.check_status_id
GROUP BY sch.pickup_date, sch.dropoff_date, beach.name, cop.name, car.color, ing.description, expectedAmount, check_status;





SELECT * FROM  VW_integrityCheck; 

    
DROP VIEW IF EXISTS VW_CashboxIntegrity;
CREATE VIEW VW_ConsistencyCheck AS
	SELECT
	sch.pickup_date,
	sch.dropoff_date,
	beach.name AS beach,
	cop.name,
	car.color,
    cb_check.real_amount AS expectedAmount,
    cb.amount AS realCashAmount,
	CASE 
        WHEN check_s.status_name = "correcto"  THEN 'clean' 
		WHEN check_s.status_name = "pendiente" THEN "pending"
        ELSE 'inconsistency'
	END AS check_status
FROM schedules sch
	INNER JOIN beaches beach ON sch.playa_id = beach.beach_id
	INNER JOIN coperos cop ON cop.copero_id = sch.copero_id
	INNER JOIN cars car ON car.car_id = sch.carrito_id
    INNER JOIN cashbox_checks cb_check ON cb_check.first_copero = cop.copero_id
    INNER JOIN cashboxes cb  ON cb.car_id = car.car_id
	INNER JOIN check_statuses check_s ON check_s.check_status_id = cb_check.check_status_id
GROUP BY sch.pickup_date, sch.dropoff_date, beach.name, cop.name, car.color, expectedAmount, realCashAmount, check_status;

SELECT * FROM  VW_integrityCheck; 


		

