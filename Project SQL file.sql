-- PROJECT: RETAIL SALES ANALYSIS

--CREATING DATABASE
CREATE DATABASE Sql_1;

--CREATE TABLE
DROP TABLE IF EXISTS retail_sales_analysis;

CREATE TABLE retail_sales_analysis(
	transactions_id INT PRIMARY KEY,
	sale_date DATE,
	sale_time TIME,
	customer_id INT,
	gender VARCHAR(10),
	age INT,
	category VARCHAR(50),
	quantiy INT,
	price_per_unit NUMERIC(10,2),
	cogs NUMERIC(10,2),
	total_sale NUMERIC(10,2)
);

SELECT * FROM retail_sales_analysis;

--CLEANING DATA & DEALING WITH NULL VALUES IN DATA

SELECT * FROM retail_sales_analysis
WHERE transactions_id IS NULL;

SELECT * FROM retail_sales_analysis
WHERE sale_date IS NULL
	  OR
	  transactions_id IS NULL
	  OR
	  sale_time IS NULL
	  OR
	  customer_id IS NULL
	  OR
	  gender IS NULL
	  OR
	  age IS NULL
	  OR
	  category IS NULL
	  OR
	  quantiy IS NULL
	  OR
	  price_per_unit IS NULL
	  OR
	  cogs IS NULL
	  OR
	  total_sale IS NULL;

--deleting the NULL rows, because we dont have proper data

DELETE FROM retail_sales_analysis
WHERE sale_date IS NULL
	  OR
	  transactions_id IS NULL
	  OR
	  sale_time IS NULL
	  OR
	  customer_id IS NULL
	  OR
	  gender IS NULL
	  OR
	  age IS NULL
	  OR
	  category IS NULL
	  OR
	  quantiy IS NULL
	  OR
	  price_per_unit IS NULL
	  OR
	  cogs IS NULL
	  OR
	  total_sale IS NULL;

SELECT * FROM retail_sales_analysis;

--Data Exploration

--How many sales we have

SELECT COUNT(*) AS total_sales FROM retail_sales_analysis;

--How many customers we have

SELECT COUNT(DISTINCT(customer_id)) AS customers_count FROM retail_sales_analysis;

--How many categories we have

SELECT DISTINCT(category) FROM retail_sales_analysis;


--Data Analysis & Business Key Problems, Answers

-- Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

SELECT * FROM retail_sales_analysis
WHERE sale_date = '2022-11-05';


/* Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 
in the month of Nov-2022*/


SELECT *
FROM retail_sales_analysis
WHERE category = 'Clothing' AND TO_CHAR(sale_date,'YYYY-MM') = '2022-11' AND quantiy>=4;


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT category,SUM(total_sale) AS total_sales
FROM retail_sales_analysis
GROUP BY category;


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT category,ROUND(AVG(age),2) AS Avg_age_customers
FROM retail_sales_analysis
WHERE category = 'Beauty'
GROUP BY category;


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT * 
FROM retail_sales_analysis
WHERE total_sale > 1000;


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT category,gender,COUNT(transactions_id)
FROM retail_sales_analysis
GROUP BY category,gender
ORDER BY category ASC;


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT year,month,avg_sales FROM
	(
		SELECT EXTRACT(YEAR FROM sale_date) AS year, 
			EXTRACT(MONTH FROM sale_date) AS month, 
			ROUND(AVG(total_sale),2) AS avg_sales,
			RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY 	ROUND(AVG(total_sale),2) DESC)
		FROM retail_sales_analysis
		GROUP BY year,month
	)
WHERE RANK = 1;

--ORDER BY year,avg_sales DESC;


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT * FROM retail_sales_analysis;

SELECT customer_id,sum(total_sale) AS highest_total_sales
FROM retail_sales_analysis 
GROUP BY 1
ORDER BY 2 DESC LIMIT 5;



-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT category,COUNT(DISTINCT(customer_id)) AS no_unique_customers
FROM retail_sales_analysis
GROUP BY 1

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
SELECT * FROM retail_sales_analysis;

WITH shifts_table
	AS	
	(
		SELECT *,
			CASE
			WHEN EXTRACT(HOUR FROM sale_time)<=12 THEN 'Morning'
			WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
			ELSE 'Evening'
			END AS Shift
		FROM retail_sales_analysis
	)
SELECT shift,COUNT(transactions_id) AS total_shift_orders
FROM shifts_table
GROUP BY 1;


--END OF PROJECT
