WITH p1 as ( -- max quant of prods for spring
	SELECT prod, MAX(quant) max_q_spring
	FROM sales
	WHERE month in (3, 4, 5)
	GROUP BY prod
),
p1date as ( -- get corresponding dates for spring
	SELECT p1.prod, max_q_spring, s.date max_q_spring_date
	FROM sales s join p1 ON s.prod = p1.prod AND s.quant = p1.max_q_spring AND s.month in (3, 4, 5)
),
p2 as ( -- max quant of prodsfor summer
	SELECT prod, MAX(quant) max_q_summer
	FROM sales
	WHERE month in (6, 7, 8)
	GROUP BY prod
),
p2date as ( -- get corresponding dates for summer
	SELECT p2.prod, max_q_summer, s.date max_q_summer_date
	FROM sales s join p2 ON s.prod = p2.prod AND s.quant = p2.max_q_summer AND s.month in (6, 7, 8)
),
p3 as ( -- max quant of prods for fall
	SELECT prod, MAX(quant) max_q_fall
	FROM sales
	WHERE month in (9, 10, 11)
	GROUP BY prod
),
p3date as ( -- get corresponding dates for fall
	SELECT p3.prod, max_q_fall, s.date max_q_fall_date
	FROM sales s join p3 ON s.prod = p3.prod AND s.quant = p3.max_q_fall AND s.month in (9, 10, 11)
),
p4 as ( -- max quant of prods for winter
	SELECT prod, MAX(quant) max_q_winter
	FROM sales
	WHERE month in (12, 1, 2)
	GROUP BY prod
),
p4date as ( -- get corresponding dates for winter
	SELECT p4.prod, max_q_winter, s.date max_q_winter_date
	FROM sales s join p4 ON s.prod = p4.prod AND s.quant = p4.max_q_winter AND s.month in (12, 1, 2)
)

-- query all relevant data
SELECT p1date.prod, p1date.max_q_spring, p1date.max_q_spring_date, p2date.max_q_summer, p2date.max_q_summer_date,
p3date.max_q_fall, p3date.max_q_fall_date, p4date.max_q_winter, p4date.max_q_winter_date
FROM p1date JOIN p2date ON p1date.prod = p2date.prod 
JOIN p3date ON p1date.prod = p3date.prod 
JOIN p4date ON p1date.prod = p4date.prod