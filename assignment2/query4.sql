WITH OrderedPositions AS (
  SELECT s1.prod, s1.quant, COUNT(s2.quant) pos
  FROM sales s1
  JOIN sales s2
  ON s1.prod = s2.prod AND s2.quant <= s1.quant
  GROUP BY s1.prod, s1.quant
),
  ProductTotalSales AS (
    SELECT prod, COUNT(quant) total_sales
    FROM sales
    GROUP BY prod
),
  MedianPositions AS (
  SELECT op.prod, MIN(op.pos) median_pos
  FROM OrderedPositions op
  JOIN ProductTotalSales pts
    ON op.prod = pts.prod
  WHERE
    op.pos >= CEILING(pts.total_sales / 2.0) /*median condition*/
  GROUP BY
    op.prod
)
SELECT mp.prod, MIN(op.quant) median_sales_quantity
FROM MedianPositions mp
JOIN OrderedPositions op
ON mp.prod = op.prod AND mp.median_pos = op.pos
GROUP BY mp.prod
ORDER BY mp.prod