WITH p1 AS ( -- calc min, max, and avg quant for each cust
	SELECT cust, min(quant) min_q, max(quant) max_q, avg(quant) avg_q
	FROM sales
	GROUP BY cust
),
p2 AS ( -- remaining cols beside each pair of (cust, min_q)
	SELECT p1.cust, p1.min_q, s.prod min_prod, s.day min_day, s.month min_month, s.year min_year, s.state min_state
	FROM p1 JOIN sales s ON p1.cust = s.cust AND p1.min_q = s.quant
),
p3 AS ( -- remaining cols beside each pair of (cust, max_q)
	SELECT p1.cust, p1.max_q, s.prod max_prod, s.day max_day, s.month max_month, s.year max_year, s.state max_state
	FROM p1 JOIN sales s ON p1.cust = s.cust AND p1.max_q = s.quant
)

-- join all three tables selecting the cols we want
SELECT p2.cust, p2.min_q, p2.min_prod, p2.min_day, p2.min_month, p2.min_year, p2.min_state,
p3.max_q, p3.max_prod, p3.max_day, p3.max_month, p3.max_year, p3.max_state, p1.avg_q
FROM p2 JOIN p3 ON p2.cust = p3.cust JOIN p1 ON p2.cust = p1.cust