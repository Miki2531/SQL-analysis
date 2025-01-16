/*  QUESTION: Immediate Food Delivery II

Table: Delivery
+-----------------------------+---------+
| Column Name                 | Type    |
+-----------------------------+---------+
| delivery_id                 | int     |
| customer_id                 | int     |
| order_date                  | date    |
| customer_pref_delivery_date | date    |
+-----------------------------+---------+
delivery_id is the column of unique values of this table.
The table holds information about food delivery to customers that make orders at some date and specify a preferred delivery date (on the same order date or after it).

If the customer's preferred delivery date is the same as the order date, then the order is called immediate; otherwise, it is called scheduled.

The first order of a customer is the order with the earliest order date that the customer made. It is guaranteed that a customer has precisely one first order.

Write a solution to find the percentage of immediate orders in the first orders of all customers, rounded to 2 decimal places.

The result format is in the following example.

Input: 
Delivery table:
+-------------+-------------+------------+-----------------------------+
| delivery_id | customer_id | order_date | customer_pref_delivery_date |
+-------------+-------------+------------+-----------------------------+
| 1           | 1           | 2019-08-01 | 2019-08-02                  |
| 2           | 2           | 2019-08-02 | 2019-08-02                  |
| 3           | 1           | 2019-08-11 | 2019-08-12                  |
| 4           | 3           | 2019-08-24 | 2019-08-24                  |
| 5           | 3           | 2019-08-21 | 2019-08-22                  |
| 6           | 2           | 2019-08-11 | 2019-08-13                  |
| 7           | 4           | 2019-08-09 | 2019-08-09                  |
+-------------+-------------+------------+-----------------------------+


*/

WITH firstOrder AS (
    SELECT customer_id, MIN(order_date) as first_order
    FROM Delivery
    GROUP BY customer_id
),
FirstOrderDetail AS (
    SELECT d.delivery_id, d.customer_id, d.order_date, d.customer_pref_delivery_date
    FROM Delivery d
    JOIN firstOrder fo ON d.customer_id = fo.customer_id AND d.order_date = fo.first_order
), 
immediateOrder AS (
    SELECT COUNT(*) AS immediate_count
    FROM FirstOrderDetail
    WHERE order_date = customer_pref_delivery_date
),
TotalFirstOrder AS (
    select count(*) AS total_count
    FROM FirstOrderDetail
)

SELECT ROUND((io.immediate_count * 100.0) / tf.total_count, 2) AS immediate_percentage
FROM immediateOrder io, TotalFirstOrder tf;