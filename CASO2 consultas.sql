USE Copos;

SET @startingDate = '2023-03-18';
SET @endDate = '2023-03-20';

SELECT 
	ing.description,
    @startingDate AS startingDate,
    @endDate AS endDate,
    SUM(CASE WHEN inv.operation_type = 'refill' THEN inv.quantity ELSE 0 END) AS refill_total,
    SUM(CASE WHEN inv.operation_type = 'sale' THEN inv.quantity ELSE 0 END) AS sale_total,
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
	SUM(IFNULL(ivoices.total_paid, 0)) AS total_copero_payment,
    cop.name AS copero
FROM coperos cop 
INNER JOIN invoices ivoices ON ivoices.copero_id = cop.copero_id
GROUP BY cop.name;



    

    
    







