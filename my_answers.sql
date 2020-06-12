-- Practice Joins

SELECT * FROM invoice i
JOIN invoice_line il ON il.invoice.id = i.invoice_id
WHERE li.unit_price > 0.99;

SELECT i.invoice_date, c.first_name, c.last_name, i.total
FROM invoice i
JOIN customer c ON i.customer_id = c.customer_id;

SELECT c.first_name, c.last_name, e.first_name, e.last_name
FROM customer c
JOIN employee e ON c.support_rep_id = e.employee_id;

SELECT al.title, ar.last_name
FROM album al
JOIN artist ar ON al.artist_id = ar.artist_id;

SELECT pt.track_id
FROM playlist_track pt
JOIN playlist p ON p.playlist_id = pt.playlist_id
WHERE p.name = 'Mustic';

SELECT t.name
FROM track t
JOIN playlist_track pt ON pt.track_id = t.track_id
WHERE pt.playlist_id = 5;

SELECT t.name, p.name
FROM track t
JOIN platlist_track pt ON t.track_id = pt.track_id
JOIN playlist p ON pt.playlist_id = p.playlist_id;

SELECT t.name, a.title
FROM track t
JOIN album a ON t.album_id = a.album_id
JOIN genre g ON g.genre_id = t.genre_id
WHERE g.name = 'Alternative & Punk';

--Nested Queries

SELECT *
FROM invoice
WHERE invoice_id IN (SELECT invoice_id FROM invoice_line WHERE unit_price > 0.99);

SELECT *
FROM playlist_track
WHERE playlist_id IN (SELECT playlist_id FROM playlist WHERE name = 'Music');

SELECT name
FROM track
WHERE track_id IN (SELECT track_id FROM playlist_track WHERE playlist_id = 5);

SELECT *
FROM track
WHERE genre_id IN (SELECT genre_id FROM genre WHERE name = 'Comedy');

SELECT *
FROM track
WHERE album_id IN (SELECT album_id FROM album WHERE title = 'Fireball');

SELECT *
FROM track
WHERE album_id IN (
    SELECT album_id FROM album WHERE artist_id IN (
        SELECT artist_id FROM artist WHERE name = 'Queen'
    )
);

-- Updating Rows

UPDATE customer
SET fax = null
WHERE fax IS NOT null;

UPDATE customer
SET company = 'Self'
WHERE company IS null;

UPDATE customer
SET last_name = 'Thompson'
WHERE fist_name = 'Julia' AND last_name = 'Barnett';

UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.com';

UPDATE track
SET composer = 'The darkness around us'
WHERE genre_id = (SELECT genre_id FROM genre WHERE name = 'Metal')
AND composer IS null;

-- Group by

SELECT COUNT(*), g.name
FROM track t
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.name;

SELECT COUNT(*), g.name
FROM track t
JOIN genre g ON g.genre_id = t.genre_id
WHERE g.name = 'Pop' OR g.name = 'Rock'
GROUP BY g.name;

SELECT COUNT(*), ar.name
FROM album al
JOIN artist ar ON ar.artist_id = al.artist_id
GROUP BY ar.name;

-- USe Distinct

SELECT DISTINCT composer
FROM track;

SELECT DISTINCT billing_postal_code
FROM invoice;

SELECT DISTINCT company
FROM customer;

-- Delete Rows

DELETE
FROM practice_delete
WHERE type = 'bronze';

DELETE
FROM practice_delete
WHERE type = 'silver';

DELETE
FROM practice_delete
WHERE value = 150;

-- eCommerce Simulation

CREATE TABLE users (
    userId PRIMARY SERIAL KEY,
    name VARCHAR(50),
    email VARCHAR(40)
)

CREATE TABLE products (
    productId PRIMARY SERIAL KEY,
    name VARCHAR(50),
    price INTEGER
)

CREATE TABLE orders (
    orderId SERIAL PRIMARY KEY,
    productId INTEGER REFERENCES products(productId),
    userId INTEGER REFERENCES users(userId),
    quantity INTEGER
)

-- Add users

INSERT INTO users
(name, email)
VALUES
('Triston', 'thisismyemail358@gmail.com');

INSERT INTO users
(name, email)
VALUES
('Julia', 'juliaswissgal777@gmail.com');

INSERT INTO users
(name, email)
VALUES
('Simba', 'theonetrueking98@gmail.com');

-- Add products

INSERT INTO products
(name, price)
VALUES
('Avocado', 0.50);

INSERT INTO products
(name, price)
VALUES
('Watermelon', 3.50);

INSERT INTO products
(name, price)
VALUES
('Jackfruit', 20.99);

-- Add orders

INSERT INTO orders
(productId, quantity, userId)
VALUES
(1, 50, 1);

INSERT INTO orders
(productId, quantity, userId)
VALUES
(2, 15, 2);

INSERT INTO orders
(productId, quantity, userId)
VALUES
(3, 20, 3);

-- Run queries

SELECT * FROM orders o
WHERE o.orderId = 1;

SELECT * FROM orders;

SELECT o.orderId, sum(products.price * o.quantity) FROM orders o
WHERE o.orderId = 1;

SELECT * FROM users u
JOIN order o ON o.userId = u.userId
WHERE u.userId = 1
GROUP BY u.userId, o.orderId;

SELECT * FROM u.name, count(o.orderId) AS totalOrders
FROM users u
JOIN orders o ON o.userId = u.userId
GROUP BY u.userId;