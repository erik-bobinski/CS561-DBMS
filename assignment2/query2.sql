WITH QuarterSales AS (
  SELECT cust, prod, CEILING(month / 3.0) quarter, AVG(quant) avg_quant
  FROM sales
  GROUP BY cust, prod, quarter
)
SELECT
  qs.cust customer,
  qs.prod product,
  qs.quarter quarter,
  ROUND(before_qs.avg_quant, 2) avg_sales_before,
  ROUND(qs.avg_quant, 2) avg_sales_during,
  ROUND(after_qs.avg_quant, 2) avg_sales_after
FROM QuarterSales qs
LEFT JOIN QuarterSales before_qs
  ON qs.cust = before_qs.cust
  AND qs.prod = before_qs.prod
  AND qs.quarter = before_qs.quarter + 1
LEFT JOIN QuarterSales after_qs
  ON qs.cust = after_qs.cust
  AND qs.prod = after_qs.prod
  AND qs.quarter = after_qs.quarter - 1
ORDER BY
  qs.cust,
  qs.prod,
  qs.quarter