    /*  You own a small online store, and want to analyze customer ratings for the products that you're selling. After doing a data pull, you have a list of products and a log of purchases. Within the purchase log, each record includes the number of stars (from 1 to 5) as a customer rating for the product.

    For each category, find the lowest price among all products that received at least one 4-star or above rating from customers.
    If a product category did not have any products that received at least one 4-star or above rating, the lowest price is considered to be 0. The final output should be sorted by product category in alphabetical order.

            Table: products
                    +-------------+-------------+
                    | COLUMN_NAME | DATA_TYPE   |
                    +-------------+-------------+
                    | category    | varchar(10) |
                    | id          | int         |
                    | name        | varchar(20) |
                    | price       | int         |
                    +-------------+-------------+
            Table: purchases
                    +-------------+-----------+
                    | COLUMN_NAME | DATA_TYPE |
                    +-------------+-----------+
                    | id          | int       |
                    | product_id  | int       |
                    | stars       | int       |
                    +-------------+-----------+
*/


WITH high_star AS (
  SELECT p.category, p.price       
  FROM products p
  LEFT JOIN purchases ps ON p.id = ps.product_id 
  WHERE ps.stars >= 4
),
 category_price AS (
   SELECT category, MIN(price) AS min_price
   FROM high_star
   GROUP BY category
 )
 
 SELECT p.category, COALESCE(MIN(cp.min_price), 0) AS price
 FROM products p
 LEFT JOIN category_price cp ON p.category = cp.category
 GROUP BY p.category, cp.min_price
 ORDER BY p.category;