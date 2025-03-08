# Restaurant Database Queries

### Creating Database 

```sql
DROP SCHEMA IF EXISTS restaurant_db;
CREATE SCHEMA restaurant_db;
USE restaurant_db;


CREATE TABLE order_details (
  order_details_id SMALLINT NOT NULL,
  order_id SMALLINT NOT NULL,
  order_date DATE,
  order_time TIME,
  item_id SMALLINT,
  PRIMARY KEY (order_details_id)
);
```

```sql
--
-- Table structure for table `menu_items`
--

CREATE TABLE menu_items (
  menu_item_id SMALLINT NOT NULL,
  item_name VARCHAR(45),
  category VARCHAR(45),
  price DECIMAL(5,2),
  PRIMARY KEY (menu_item_id)
);
```
### Explore / Analyze Orders Table

```sql
USE restaurant_db;


-- 1. View the order_details table.

SELECT * FROM order_details;

-- 2. What is the date range of the table?

SELECT MIN(order_date), MAX(order_date) FROM order_details; 
-- or
SELECT * FROM order_details
ORDER BY order_date;
-- 2023-01-01 -- 2023-01-02
-- 3. How many orders were made within this date range?

SELECT COUNT(DISTINCT order_id) FROM order_details;
-- 5370

-- 4. How many items were ordered within this date range?

SELECT COUNT(*) FROM order_details;
-- 12234

-- 5. Which orders had the most number of items?

SELECT order_id, COUNT(item_id) AS num_items
FROM order_details
GROUP BY order_id
ORDER BY num_items DESC;

-- order 1957


-- 6. How many orders had more than 12 items?
SELECT COUNT(*) FROM
(SELECT order_id, COUNT(item_id) AS num_items
FROM order_details
GROUP BY order_id
HAVING num_items > 12) AS num_orders;

-- 20 orders
```

### Explore / Analyze Menu Table

```sql
USE restaurant_db;

-- 1. View the menu_items table.
SELECT * FROM menu_items;

-- 2. Find the number of items on the menu.
SELECT COUNT(*) FROM menu_items;
-- 32

-- 3. What are the least and most expensive items on the menu?
SELECT * FROM menu_items
ORDER BY price;

SELECT * FROM menu_items
ORDER BY price DESC;
-- Most expensive : Shrimp Scami
-- Least expensive : Edamame

-- 4. How many Italian dishes are on the menu?
SELECT COUNT(*) FROM menu_items
WHERE category="Italian";
-- 9

-- 5. What are the least and most expensive Italian disbes on the menu?
SELECT * FROM menu_items
WHERE category="Italian"
ORDER BY price;

SELECT * FROM menu_items
WHERE category="Italian"
ORDER By price DESC;

-- Most expensive: Shrimp Scampi
-- Least expensive: Fettuccine Alfredo

-- 6. How many dishes are in each category?
SELECT category, COUNT(menu_item_id) AS num_dishes
FROM menu_items
GROUP BY category;

-- American: 9 Asian: 8 Mexican: 9 Italian: 9

-- 7. What is the average dish price within each category? 
SELECT category, AVG(menu_item_id) AS avg_dishes
FROM menu_items
GROUP BY category;
-- American: 103.50$ 
-- Asian: 110.50$
-- Mexican: 119.00$
-- Italian: 128.00$
```

### Exploratory Data Analysis of Entire Resturant Database

```sql

-- 1. Combine the menu_items table and order_details tables into a single table
SELECT * FROM menu_items;
SELECT * FROM order_details;

SELECT *
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id;

-- 2. What were the least and most ordered items? What categories were they in?
SELECT item_name, category, COUNT(order_details_id) AS num_purchases
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
GROUP BY item_name, category
ORDER BY num_purchases DESC;

-- Least ordered: Chicken Tacos (Mexican)
-- Most ordered: Hamburger (American)

-- 3. What were the top 5 orders that spent the most money?
SELECT order_id, SUM(price) AS total_spend
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
GROUP BY order_id
ORDER BY total_spend DESC 
LIMIT 5;

-- order_id: 440 (192.15$)
-- order_id: 2075 (191.05$)
-- order_id: 1957 (190.10$)
-- order_id: 330 (189.70$)
-- order_id: 267 (185.10$)

-- 4. View the details of the highest spend order. What insights can you gather from the results?
SELECT category, COUNT(item_id) AS num_items
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
WHERE order_id = 440
GROUP BY category;

-- The highest spend order purchased a majority of Italian orders.

-- 5. View the details of the top 5 highest spend orders. What insights can you gather from the results?
SELECT order_id, category, COUNT(item_id) AS num_items
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
WHERE order_id IN (440, 2075, 1957, 330, 2675)
GROUP BY order_id, category;

-- The top highest spend orders are ordering Italian more than all other types of menu categories.
```
