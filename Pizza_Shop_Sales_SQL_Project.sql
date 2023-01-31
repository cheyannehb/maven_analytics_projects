--- Average pizza price

SELECT ROUND(AVG(price),2) AS avg_price
FROM slice_baby.pizzas;

--- Total pizzas orders by type

SELECT pizza_id, COUNT(quantity) AS order_total
FROM slice_baby.order_details
GROUP BY pizza_id
ORDER BY order_total DESC;

--- Busiest day of the week for 2015

SELECT dayofweek(date), COUNT(DISTINCT order_id)
FROM slice_baby.orders
GROUP BY dayofweek(date) 
ORDER BY dayofweek(date);

--- Most popular pizza sizes sold for 2015

SELECT SUM(quantity) AS total_quantity, size
FROM slice_baby.order_details
LEFT JOIN slice_baby.pizzas
USING (pizza_id)
GROUP BY size
ORDER BY total_quantity DESC;

--- Top 10 most ordered types of pizza for the year

SELECT pizza_id, SUM(quantity) AS order_total
FROM slice_baby.order_details
GROUP BY pizza_id
ORDER BY order_total DESC
LIMIT 10;

--- Bottom 10 least ordered types of pizza for the year

SELECT pizza_id, SUM(quantity) AS order_total
FROM slice_baby.order_details
GROUP BY pizza_id
ORDER BY order_total ASC
LIMIT 10;

--- All details for orders for the first week of January, 2015

SELECT orders.order_id, date, time, order_details.pizza_id, order_details.quantity
FROM slice_baby.orders
INNER JOIN slice_baby.order_details
ON orders.order_id=order_details.order_id
WHERE date BETWEEN "2015-01-01" AND "2015-01-08"
ORDER BY order_id;

--- Order with the most pizzas ordered

SELECT order_details.order_id, date, SUM(order_details.quantity) AS total_per_order
FROM slice_baby.order_details
INNER JOIN slice_baby.orders
ON orders.order_id=order_details.order_id
WHERE date
GROUP BY order_id
ORDER BY total_per_order DESC
LIMIT 1;

--- Order with the least pizzas ordered

SELECT order_details.order_id, date, SUM(order_details.quantity) AS total_per_order
FROM slice_baby.order_details
INNER JOIN slice_baby.orders
ON orders.order_id=order_details.order_id
WHERE date
GROUP BY order_id
ORDER BY total_per_order ASC
LIMIT 1;

--- Daily order totals for the year

SELECT DISTINCT (COUNT(order_id)), date
FROM slice_baby.orders
GROUP BY date;

--- Total orders for the year

SELECT DISTINCT COUNT(order_id) AS total_orders
FROM slice_baby.orders;

--- Total pizzas sold for the year

SELECT COUNT(quantity) AS total_pizzas
FROM slice_baby.order_details;
    
--- Top 10 most expensive orders

SELECT order_id,SUM(quantity) AS total_quantity, ROUND(SUM(price),2) AS order_total
FROM slice_baby.order_details
LEFT JOIN slice_baby.pizzas
USING (pizza_id)
GROUP BY order_id
ORDER BY order_total DESC
LIMIT 10;

--- Total revenue and orders for the year by month

SELECT MONTH(date),SUM(quantity) AS total_quantity, ROUND(SUM(price),2) AS order_total
FROM slice_baby.orders
INNER JOIN slice_baby.order_details
USING (order_id)
INNER JOIN slice_baby.pizzas
USING (pizza_id)
GROUP BY month(date)
ORDER BY MONTH(date);

--- Average sales per month, busiest month and total sales per month

SELECT MONTH(date), SUM(quantity) AS total_quantity, ROUND(SUM(price),2) AS order_total, 
ROUND(SUM(quantity)/12,-1) AS avg_orders_per_month
FROM slice_baby.orders
INNER JOIN slice_baby.order_details
USING (order_id)
INNER JOIN slice_baby.pizzas
USING (pizza_id)
GROUP BY month(date)
ORDER BY order_total DESC;