/* QUESTION: You are a data analyst working for an e-commerce company, responsible for analysing customer orders to gain insights into their purchasing behaviour. Your task is to write a SQL query to retrieve the details of the penultimate order for each customer. However, if a customer has placed only one order, you need to retrieve the details of that order instead, display the output in ascending order of customer name.

NOTE : The term "penultimate order" refers to the second-to-last order.

    Table: orders
    +---------------+-------------+
    | COLUMN_NAME   | DATA_TYPE   |
    +---------------+-------------+
    | order_id      | int         |
    | order_date    | date        |
    | customer_name | varchar(10) |
    | product_name  | varchar(10) |
    | sales         | int         |
    +---------------+-------------+

*/

WITH customer_rnk AS (
  SELECT order_id, order_date, customer_name, product_name,sales,
  	ROW_NUMBER() OVER(partition BY customer_name ORDER BY order_date DESC) AS row_rnk,
  	COUNT(order_id) OVER(partition BY customer_name) AS ord_count
  FROM orders
)
SELECT order_id, order_date, customer_name, product_name,sales
FROM customer_rnk 
WHERE row_rnk = 2 OR ord_count = 1
ORDER BY customer_name;