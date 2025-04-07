WITH p1 AS ( -- count(quant) for each (cust, prod)
	SELECT cust, prod, COUNT(quant) count_q
	FROM sales
	GROUP BY cust, prod
),
p2 AS ( -- quantities of most and least fav product for each customer
	SELECT cust, MAX(count_q) most_fav_count, MIN(count_q) least_fav_count
	FROM p1
	GROUP BY cust
),
p3 AS ( -- corresponding product for the most fav quant
	SELECT p2.cust, p1.prod most_fav_prod
	FROM p1, p2
	WHERE p1.cust = p2.cust AND p1.count_q = p2.most_fav_count
),
p4 AS ( -- corresponding product for the least fav quant
	SELECT p2.cust, p1.prod least_fav_prod
	FROM p1, p2
	WHERE p1.cust = p2.cust AND p1.count_q = p2.least_fav_count
)

-- combine cust, most fav prod, and least fav prod into on table
SELECT p3.cust, p3.most_fav_prod, p4.least_fav_prod
FROM p3, p4
WHERE p3.cust = p4.cust