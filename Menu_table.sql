USE restaurant_db;

-- 1. View the menu_items table.
```sql
SELECT * FROM menu_items;
```
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
