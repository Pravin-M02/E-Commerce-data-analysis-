
-- E-Commerce Data Analysis
-- Created using MySQL Workbench

-- Checking the customer data
SELECT *
FROM customers;

-- Checking the order data
SELECT *
FROM orders;

-- Total number of customers
SELECT COUNT(*) AS total_customers
FROM customers;

-- Customers from Chennai
SELECT customer_id, customer_name, city
FROM customers
WHERE city = 'Chennai';

-- Orders which are delivered
SELECT *
FROM orders
WHERE order_status = 'Delivered';

-- Orders placed after January 2025
SELECT *
FROM orders
WHERE order_date > '2025-01-01';

-- Latest 10 orders
SELECT *
FROM orders
ORDER BY order_date DESC
LIMIT 10;

-- Average product price
SELECT ROUND(AVG(list_price), 2) AS average_price
FROM products;

-- Total sales
SELECT ROUND(SUM(net_sales), 2) AS total_sales
FROM order_items;

-- Number of orders by status
SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- Sales by product category
SELECT
    p.category,
    ROUND(SUM(oi.net_sales), 2) AS total_sales
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY total_sales DESC;

-- Customer details with their orders
SELECT
    c.customer_name,
    o.order_id,
    o.order_date,
    o.order_status
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id;

-- Top 5 customers by sales
SELECT
    c.customer_name,
    ROUND(SUM(oi.net_sales), 2) AS total_sales
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY c.customer_id, c.customer_name
ORDER BY total_sales DESC
LIMIT 5;

-- Monthly sales
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    ROUND(SUM(oi.net_sales), 2) AS monthly_sales
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY month;

-- Payment status analysis
SELECT
    payment_status,
    COUNT(*) AS payment_count
FROM payments
GROUP BY payment_status;

-- Return reason analysis
SELECT
    return_reason,
    COUNT(*) AS return_count
FROM returns
GROUP BY return_reason
ORDER BY return_count DESC;
