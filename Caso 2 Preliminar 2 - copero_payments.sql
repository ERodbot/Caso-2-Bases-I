INSERT INTO copero_payments ( invoice_id, enabled, commission_id, payday, created_at, updated_at, computer, username, checksum)
SELECT invoice_id, 1, 1, c.percentage * iv.total_cost, iv.date, iv.date, "me", "root", SHA2("password",256)
FROM invoices iv
JOIN commissions c ON c.enabled = 1 AND c.final_date > iv.date;