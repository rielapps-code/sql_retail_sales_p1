-- ZERO ANALYST ON YOUTUBE

SELECT * FROM public.retail_sales
ORDER BY transactions_id ASC LIMIT 100

 --Data Cleaning

SELECT * FROM retail_sales
LIMIT 10

SELECT 
	COUNT(*)
FROM retail_sales

SELECT * FROM retail_sales
WHERE transactions_id IS NULL

SELECT * FROM retail_sales
WHERE sale_date IS NULL

SELECT * FROM retail_sales
WHERE sale_time IS NULL

SELECT * FROM retail_sales
WHERE 
	transactions_id IS NULL
	OR 
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR 
	gender IS NULL
	OR 
	category IS NULL
	OR 
	quantiy IS NULL
	OR 
	age IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL



DELETE FROM retail_sales
WHERE 
	transactions_id IS NULL
	OR 
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR 
	gender IS NULL
	OR 
	category IS NULL
	OR 
	quantiy IS NULL
	OR 
	age IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL

SELECT * FROM retail_sales
WHERE 
	transactions_id IS NULL
	OR 
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR 
	gender IS NULL
	OR 
	category IS NULL
	OR 
	quantiy IS NULL
	OR 
	age IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL



-- Data Exploration

-- How many sales do wew have?

SELECT COUNT(total_sale) as total_sale FROM retail_sales


-- How many unique customers do we have?

SELECT COUNT( distinct customer_id) AS customer_id from retail_sales


SELECT COUNT( distinct category) AS category from retail_sales

SELECT DISTINCT category from retail_sales


-- Data Analysis & Business Key Problems

--Q.1 Write a SQL query to reterieve all columns for sales made on '2022-11-05'
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

--Q.2 Write a SQL query to reterieve all transactions where the category is 
--'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

SELECT 
	*
FROM retail_sales
WHERE 
	category = 'Clothing'
	AND
	TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
	AND
	quantity >= 4;


-- Q3 Write a SQL query to calculate the total sales (total_sale) for each category

SELECT 
	category,
	SUM(total_sale) as net_sale,
	COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1


--Q4 Write a SQL query to find the average age of customers who purchsed items 
--from the Beauty category


SELECT 
	category,
	ROUND(AVG(age),2) as Average_Age
FROM retail_sales
WHERE category  = 'Beauty'
GROUP BY 1


SELECT 
	ROUND(AVG(age), 2) as Average_Age
FROM retail_sales
WHERE category  = 'Beauty'



-- Q5. Write a SQL query to find all transactions where total_sales is 
--greater than 1000.

SELECT *

FROM retail_sales

WHERE total_sale > 1000


-- Q6 Write a SQL query to find the total number of transactions (transaction_id)
--made by each gender in each category.

SELECT 
	category,
	gender,
	COUNT(*) as total_trans
FROM retail_sales
GROUP BY 
	category,
	gender
ORDER BY 1

-- Write a SQL query to calculate the average sale for each month. Find out 
--best selling month in each year
SELECT 
	year, 
	month,
	avg_sale
FROM 
(
	SELECT 
		EXTRACT(YEAR FROM sale_date) as year,
		EXTRACT(MONTH FROM sale_date) as month,
		AVG(total_sale) as Avg_Sale,
		RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date)ORDER BY AVG(total_sale) DESC)
	FROM retail_sales
	GROUP BY 1, 2
) as t1
WHERE RANK = 1


-- ORDER BY 1, 3 DESC


--Q.8 Write a SQL query to find the top 5 customers based on the highest total sales

SELECT 
	customer_id,
	SUM(total_sale) as total_sales,
	COUNT(transactions_id) as trans_id
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5


--Q.9 Write a SQL query to find the number of unique customers who purchased items from each category

SELECT 
	category,
	COUNT(DISTINCT customer_id) as count_of_unique_cust
FROM retail_sales
GROUP BY category

--Q.10 Write a SQL query to create each shift and number of orders(example Morning <=12, Afternoon Between 
--12 & 17, Evening >17)
WITH hourly_sale
AS
(
	SELECT *,
		CASE
			WHEN EXTRACT (HOUR FROM sale_time) < 12 THEN 'Morning'
			WHEN EXTRACT (HOUR FROM sale_time)  BETWEEN 12 AND 17 THEN 'Afternoon'
			ELSE 'Evening'
		END  as shift
	FROM retail_sales
)
SELECT 
	shift,
	COUNT(*) as total_orders
FROM  hourly_sale  
GROUP BY shift


-- End of Project