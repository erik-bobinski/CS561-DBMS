WITH MonthlySales AS (
  SELECT prod, month, AVG(quant) avg_quant
  FROM sales
  GROUP BY prod, month
), LaggedSales AS (
  SELECT
    ms.prod,
    ms.month,
    ms.avg_quant current_avg_quant,
    prev_ms.avg_quant prev_avg_quant,
    next_ms.avg_quant next_avg_quant
  FROM MonthlySales ms
  LEFT JOIN MonthlySales prev_ms
    ON ms.prod = prev_ms.prod
    AND ms.month = prev_ms.month + 1
  LEFT JOIN MonthlySales next_ms
    ON ms.prod = next_ms.prod
    AND ms.month = next_ms.month - 1
)
SELECT
  ls.prod,
  ls.month,
  COUNT(s.quant) transactions_between_avgs
FROM LaggedSales ls
LEFT JOIN sales s
  ON ls.prod = s.prod
  AND ls.month = s.month
  AND s.quant > ls.prev_avg_quant
  AND s.quant < ls.next_avg_quant
WHERE
  ls.prev_avg_quant IS NOT NULL
  AND ls.next_avg_quant IS NOT NULL
GROUP BY
  ls.prod,
  ls.month
ORDER BY
  ls.prod,
  ls.month
