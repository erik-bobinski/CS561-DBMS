WITH p1 AS (
    SELECT cust, prod, state, AVG(quant) avg_quant
    FROM sales
    GROUP BY cust, prod, state
),
OtherProds AS (
    SELECT p1.cust, p1.prod, p1.state, AVG(s.quant) other_prods_avg
    FROM sales s, p1
    WHERE s.cust = p1.cust AND s.state = p1.state AND s.prod != p1.prod
    GROUP BY p1.cust, p1.prod, p1.state
),
OtherCusts AS (
    SELECT p1.cust, p1.prod, p1.state, AVG(s.quant) other_custs_avg
    FROM sales s, p1
    WHERE s.cust != p1.cust AND s.state = p1.state AND s.prod = p1.prod
    GROUP BY p1.cust, p1.prod, p1.state
)
SELECT p1.cust, p1.prod, p1.state, avg_quant, other_prods_avg, other_custs_avg
FROM p1, OtherProds, OtherCusts
WHERE p1.cust = OtherProds.cust AND OtherProds.cust = OtherCusts.cust 
AND p1.prod = OtherProds.prod AND OtherProds.prod = OtherCusts.prod
AND p1.state = OtherProds.state AND OtherProds.state = OtherCusts.state