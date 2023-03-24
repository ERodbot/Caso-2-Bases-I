INSERT INTO copero_payments ( invoice_id, enabled, commission_id, payday, created_at, updated_at, computer, username, checksum)
SELECT invoice_id, 1, c.commission_id, c.percentage * iv.total_cost, iv.date, iv.date, "me", "root", SHA2("password",256)
FROM invoices iv
LEFT JOIN commissions c ON c.final_date >= DATE(iv.date) AND c.initial_date <= DATE(iv.date);

SELECT * FROM copero_payments;
SELECT * FROM commissions;