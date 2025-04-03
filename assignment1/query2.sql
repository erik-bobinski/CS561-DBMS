WITH p1 AS ( -- total q for each unique day
	SELECT year, month, day, SUM(quant) sum_q
	FROM sales
	GROUP BY year, month, day 
),
p2 AS ( -- highest q of each month of each year
	SELECT year, month, MAX(sum_q) busiest_total_q
	FROM p1
	GROUP BY year, month
),
p3 AS ( -- lowest q of each month of each year
	SELECT year, month, MIN(sum_q) slowest_total_q
	FROM p1
	GROUP BY year, month
),
p4 AS ( -- corresponding day for each max q
	SELECT p2.year, p2.month, p1.day busiest_day, p2.busiest_total_q busiest_day_q
	FROM p1, p2
	WHERE p1.year = p2.year AND p1.month = p2.month AND p1.sum_q = p2.busiest_total_q
),
p5 AS ( -- corresponding day for each min q
	SELECT p3.year, p3.month, p1.day slowest_day, p3.slowest_total_q slowest_day_q
	FROM p1, p3
	WHERE p1.year = p3.year AND p1.month = p3.month AND p1.sum_q = p3.slowest_total_q
)

-- display for each unique month: year, month, busiest day and its q, slowest day and its q
SELECT p4.year, p4.month, p4.busiest_day, p4.busiest_day_q, p5.slowest_day, p5.slowest_day_q
FROM p4, p5
WHERE p4.year = p5.year AND p4.month = p5.month
