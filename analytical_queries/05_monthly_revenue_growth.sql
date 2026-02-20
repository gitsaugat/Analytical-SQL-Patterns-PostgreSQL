-- Problem:
-- Calculate month-over-month revenue growth.

-- Description:
-- Computes monthly revenue, previous month revenue,
-- absolute growth, and percentage growth using window functions.

-- Grain:
-- One row per month.

-- Concepts:
-- CTE layering, LAG(), window functions, growth calculation

with month_over_month_revenue_growth as (
	SELECT 
		date_trunc('month',payment_date) as Month,
		sum(amount) as MonthlyRevenue 
	from payment 
	group by 
		Month 
	order by 
		Month
) SELECT  
    t.Month , 
    to_char(t.MonthlyRevenue,'$9999999.99')  as ThisMonthRevenue,
    to_char(LAG(t.MonthlyRevenue) OVER(ORDER BY Month) , '$999999.99' ) as PreviousMonthRevenue,
    to_char(t.MonthlyRevenue - LAG(t.MonthlyRevenue) OVER(ORDER BY Month),'$9999999.99') as Diff,
    ROUND(100*(t.MonthlyRevenue - LAG(t.MonthlyRevenue) OVER(ORDER BY Month))/LAG(t.MonthlyRevenue) OVER(ORDER BY Month),2) as MoMGrowth
from month_over_month_revenue_growth as t ;
