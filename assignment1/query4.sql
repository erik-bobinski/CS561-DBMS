WITH p1 as ( -- compute avg for spring
	SELECT cust, prod, avg(quant) spring_avg
	FROM sales
	WHERE month in (3, 4, 5)
	GROUP BY cust, prod
),
p2 as ( -- compute avg for summer
	SELECT cust, prod, avg(quant) summer_avg
	FROM sales
	WHERE month in (6, 7, 8)
	GROUP BY cust, prod
),
p3 as ( -- computer avg for fall
	SELECT cust, prod, avg(quant) fall_avg
	FROM sales
	WHERE month in (9, 10, 11)
	GROUP BY cust, prod
),
p4 as ( -- compute avg for winter
	SELECT cust, prod, avg(quant) winter_avg
	FROM sales
	WHERE month in (12, 1, 2)
	GROUP BY cust, prod
),
p5 as ( -- compute avg, total quant, and count for the whole "year", ignoring the year component
	SELECT cust, prod, avg(quant) average, sum(quant) total, count(quant) count
	FROM sales
	GROUP BY cust, prod
)

SELECT p1.cust, p1.prod, p1.spring_avg, p2.summer_avg, p3.fall_avg, p4.winter_avg, p5.average, p5.total, p5.count
FROM p1 JOIN p2 ON p1.cust = p2.cust AND p1.prod = p2.prod
JOIN p3 ON p1.cust = p3.cust AND p1.prod = p3.prod
JOIN p4 ON p1.cust = p4.cust AND p1.prod = p4.prod
JOIN p5 ON p1.cust = p5.cust AND p1.prod = p5.prod