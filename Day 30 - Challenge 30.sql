
# DAY 30 - Challenge 30

# MySQL JSON DATA TYPES AND FUNCTIONS

USE Challenge;

CREATE TABLE products (
  product_id INT PRIMARY KEY,
  product_info JSON
);

INSERT INTO products (product_id, product_info) VALUES
(1, '{"name": "Laptop", "price": 1200, "stock": 30, "categories": ["electronics", "computers"], "ratings": {"avg_rating": 4.5, "reviews": 150}}'),
(2, '{"name": "Smartphone", "price": 800, "stock": 50, "categories": ["electronics", "phones"], "ratings": {"avg_rating": 4.2, "reviews": 200}}'),
(3, '{"name": "Headphones", "price": 200, "stock": 100, "categories": ["electronics", "accessories"], "ratings": {"avg_rating": 4.7, "reviews": 80}}'),
(4, '{"name": "Tablet", "price": 400, "stock": 20, "categories": ["electronics", "computers"], "ratings": {"avg_rating": 4.0, "reviews": 50}}'),
(5, '{"name": "Smartwatch", "price": 250, "stock": 40, "categories": ["electronics", "wearables"], "ratings": {"avg_rating": 4.3, "reviews": 60}}');

SELECT * FROM products;

# 1. Extract the product name from the product_info column for all products.

SELECT JSON_UNQUOTE(JSON_EXTRACT(product_info, '$.name'))
AS product_name FROM products;

# 2. Retrieve the average rating (avg_rating) for the "Smartphone".

SELECT JSON_UNQUOTE(JSON_EXTRACT(product_info, '$.ratings.avg_rating'))
AS avg_rating FROM products
WHERE JSON_UNQUOTE(JSON_EXTRACT(product_info, '$.name')) = 'Smartphone';

# 3. List all products that have stock greater than 30.

SELECT JSON_UNQUOTE(JSON_EXTRACT(product_info, '$.name'))
AS product_name FROM products
WHERE JSON_EXTRACT(product_info, '$.stock') > 30;

# 4. Find products that belong to the "computers" category.

SELECT JSON_UNQUOTE(JSON_EXTRACT(product_info, '$.name')) 
AS product_name FROM products
WHERE JSON_CONTAINS(JSON_EXTRACT(product_info, '$.categories'), '"computers"');

# 5. Update the price of "Headphones" to $180.

UPDATE products
SET product_info = JSON_SET(product_info, '$.price', 180)
WHERE JSON_UNQUOTE(JSON_EXTRACT(product_info, '$.name')) = 'Headphones';

SET SQL_SAFE_UPDATES = 0;

# 6. Remove the "reviews" field from the ratings object for all products.

UPDATE products
SET product_info = JSON_REMOVE(product_info, '$.ratings.reviews');

# 7. Add a new field discount to the JSON object for the "Smartwatch" with a value of 10%.

UPDATE products
SET product_info = JSON_SET(product_info, '$.discount', '10%')
WHERE JSON_UNQUOTE(JSON_EXTRACT(product_info, '$.name')) = 'Smartwatch';

# 8. Retrieve products where the average rating (avg_rating) is greater than 4.2.

SELECT JSON_UNQUOTE(JSON_EXTRACT(product_info, '$.name')) AS product_name
FROM products
WHERE JSON_EXTRACT(product_info, '$.ratings.avg_rating') > 4.2;

# 9. Merge a new JSON object {"discount_end": "2024-12-31"} into the product_info of the "Smartwatch".

UPDATE products
SET product_info = JSON_MERGE(product_info, '{"discount_end": "2024-12-31"}')
WHERE JSON_UNQUOTE(JSON_EXTRACT(product_info, '$.name')) = 'Smartwatch';

# 10. Return the total stock for all products combined, using JSON functions.

SELECT SUM(JSON_EXTRACT(product_info, '$.stock')) AS total_stock
FROM products;