# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `SQL_P_1`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `SQL_P_1`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantiy sold, price per unit, cost of goods sold (COGS), and total sale amount.

```

```sql
CREATE DATABASE SQL_P_1;

CREATE TABLE retail_sales_analysis
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(50),
    quanity INT,
    price_per_unit NUMERIC(10,2),	
    cogs NUMERIC(10,2),
    total_sale NUMERIC(10,2)
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.
- **Checking Null Values:** CLEANING DATA & DEALING WITH NULL VALUES IN DATA

```sql
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
```

- **Deleting Null Values:** CLEANING DATA & DEALING WITH NULL VALUES IN DATA

```sql
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
```

--**Data Exploration**

--**How many sales we have**
```sql
SELECT COUNT(*) AS total_sales
FROM retail_sales_analysis;
```

--**How many customers we have**
```sql
SELECT COUNT(DISTINCT(customer_id)) AS customers_count 
FROM retail_sales_analysis;
```

--**How many categories we have**
```sql
SELECT DISTINCT(category) 
FROM retail_sales_analysis;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT * FROM retail_sales_analysis
WHERE sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
SELECT *
FROM retail_sales_analysis
WHERE category = 'Clothing' AND TO_CHAR(sale_date,'YYYY-MM') = '2022-11' AND quantiy>=4;
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT category,SUM(total_sale) AS total_sales
FROM retail_sales_analysis
GROUP BY category;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT category,ROUND(AVG(age),2) AS Avg_age_customers
FROM retail_sales_analysis
WHERE category = 'Beauty'
GROUP BY category;
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT * 
FROM retail_sales_analysis
WHERE total_sale > 1000;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:

```sql
SELECT category,gender,COUNT(transactions_id)
FROM retail_sales_analysis
GROUP BY category,gender
ORDER BY category ASC;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:

```sql
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
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:

```sql
SELECT customer_id,sum(total_sale) AS highest_total_sales
FROM retail_sales_analysis 
GROUP BY 1
ORDER BY 2 DESC LIMIT 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:

```sql
SELECT category,COUNT(DISTINCT(customer_id)) AS no_unique_customers
FROM retail_sales_analysis
GROUP BY 1
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:

```sql
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
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.


### Stay Updated and Join the Community

For more content on SQL, data analysis, and other data-related topics, make sure to follow me on social media and join our community:

- **LinkedIn**: [Connect with me professionally](https://www.linkedin.com/in/hemanth-kumar-amarthaluru-7a1912171/)

Thank you for your support, and I look forward to connecting with you!
