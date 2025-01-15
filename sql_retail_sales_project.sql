--create table
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );
            
            SELECT * FROM retail_sales
LIMIT 10



-- counting rows
SELECT 
    COUNT(*) 
FROM retail_sales



SELECT * FROM retail_sales_analysis.retail_sales;

select * from retail_sales
where transaction_id is null



SELECT * FROM retail_sales
WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;


-- data exploration
-- how many sales we have?

SELECT COUNT(*) as total_sale FROM retail_sales

-- How many unique customers we have ?

SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales

-- How many unique category we have ?
SELECT COUNT(DISTINCT category) as total_sale FROM retail_sales

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * from retail_sales
where sale_date = '2022-11-05'


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10?
select * from retail_sales
where category= 'Clothing'
and quantity >= 4



-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select category, sum(total_sale) as  net_sales, count(*) as total_orders from retail_sales
group by category


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select avg(age) as average_age from retail_sales
where category= 'Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from retail_sales
where total_sale > 1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM retail_sales
GROUP 
    BY 
    category,
    gender
ORDER BY 1

-- Q.7 Write a SQL query to find the top 5 customers based on the highest total sales 
select customer_id, sum(total_sale) as total_sales
from retail_sales
group by customer_id
order by total_sales desc
limit 5
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select count( distinct customer_id) as cust_id, category
from retail_sales
group by category

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift
-- Adding new column in retail_sales

ALTER TABLE retail_sales
ADD Column quality varchar(15) DEFAULT('Good');

select * from retail_sales
-- Q.11 update table with damaged quality with female gender

UPDATE retail_sales
SET quality = 'Damaged'
WHERE gender = 'Female'

select * from retail_sales


