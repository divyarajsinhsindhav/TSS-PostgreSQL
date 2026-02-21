
-- Display customer first name, last name and city.
SELECT
	c.first_name,
	c.last_name,
	city.city
FROM
	customer c
	JOIN address a USING (address_id)
	JOIN city USING (city_id);

-- Show film title and category name ordered by category.
SELECT
	f.title,
	c.name
FROM
	film f
	JOIN film_category fc USING (film_id)
	JOIN category c USING (category_id)
ORDER BY
	c.name;

-- Display customer name and payment amount where amount between 5 and 10 ordered by amount descending.
SELECT
	c.first_name || ' ' || c.last_name AS customer_name,
	p.amount
FROM
	customer c
	JOIN rental r ON c.customer_id = r.customer_id
	JOIN payment p ON p.rental_id = r.rental_id
WHERE
	p.amount BETWEEN 5 AND 10
ORDER BY
	p.amount DESC;

-- Show films where rating IN ('PG','R') with category name ordered by rating.
SELECT
	f.title AS film_title,
	c.name AS category_name,
	f.rating AS rating
FROM
	film f
	JOIN film_category fc ON f.film_id = fc.film_id
	JOIN category c ON fc.category_id = c.category_id
WHERE
	f.rating IN ('PG', 'R')
ORDER BY
	f.rating;

--  Display customer name and total number of rentals (use GROUP BY).
SELECT
	c.first_name || ' ' || c.last_name AS customer_name,
	COUNT(*) AS count_of_rental
FROM
	customer c
	JOIN rental r ON c.customer_id = r.customer_id
GROUP BY
	c.customer_id,
	c.first_name,
	c.last_name;

-- Show category name and total number of films in each category ordered by total descending.
SELECT
	c.name,
	COUNT(*) AS count_of_film
FROM
	film f
	JOIN film_category fc ON f.film_id = fc.film_id
	JOIN category c ON c.category_id = fc.category_id
GROUP BY
	c.name
ORDER BY
	count_of_film DESC;

-- Show distinct customer_ids from payment where amount IN (5,7,9)
SELECT DISTINCT
	customer_id
FROM
	payment
WHERE
	amount IN (5, 7, 9);

-- Display distinct film lengths where rating IN ('PG','G')
SELECT DISTINCT
	LENGTH
FROM
	film
WHERE
	rating IN ('PG', 'G');

-- Show distinct districts where city_id IN (1,2,3,4)
SELECT DISTINCT
	district
FROM
	address
WHERE
	city_id IN (1, 2, 3, 4);

-- Show distinct payment amounts where amount between 2 and 8 AND staff_id IN (1,2) ordered descending.
SELECT DISTINCT
	amount
FROM
	payment
WHERE
	amount BETWEEN 2 AND 8
	AND staff_id IN (1, 2)
ORDER BY amount DESC;

-- Display distinct film lengths where length between 80 and 120 AND rating IN ('PG-13','R') ordered by length.
SELECT DISTINCT
	length
FROM
	film
WHERE
	LENGTH BETWEEN 80 AND 120
	AND rating IN ('PG-13', 'R')
ORDER BY length;

-- Show distinct customer_ids where customer_id between 50 and 150 AND store_id IN (1,2).
SELECT DISTINCT
	customer_id
FROM
	customer
WHERE
	customer_id BETWEEN 50 AND 150
	AND store_id IN (1, 2);

-- Display distinct districts where city_id between 1 and 100 ordered alphabetically.
SELECT DISTINCT
	district
FROM
	address
WHERE
	city_id BETWEEN 1 AND 50;

-- Display films where length between 60 and 80 OR rating = 'PG' ordered by length.
SELECT
	title
FROM
	film
WHERE
	LE BETWEEN 60 AND 80
	OR rating = 'PG'
ORDER BY
	length;

-- Show payments where amount between 2 and 4 OR customer_id = 10 ordered by amount descending.
SELECT
	*
FROM
	payment
WHERE
	amount BETWEEN 2 AND 4
	OR customer_id = 10
ORDER BY
	amount DESC;

-- Display rentals between two dates OR staff_id = 1 ordered by rental_date.
SELECT
	*
FROM
	rental
WHERE
	rental_date BETWEEN '2005-05-01' AND '2005-05-31'
	OR staff_id = 1
ORDER BY
	rental_date;

-- Show films where replacement_cost between 15 and 20 OR rental_rate = 0.99.
SELECT 
	*
FROM
	film
WHERE
	replacement_cost BETWEEN 15 AND 20
	OR rental_rate = 0.99;

-- Display actors whose last_name between 'A' and 'F' OR first_name IN ('JOHN','MIKE').
SELECT
	*
FROM
	actor
WHERE 
	last_name BETWEEN 'A' AND 'F'
	OR first_name IN ('JOHN', 'MIKE');

-- Find out film which not yet been rentad
SELECT 
	*
FROM
	film f
LEFT JOIN inventory i
ON f.film_id = i.film_id
LEFT JOIN rental r
ON i.inventory_id = r.inventory_id
WHERE r.inventory_id IS NULL;

-- Find out total number of customer
SELECT COUNT(*)
FROM customer;

-- AVG of all the payments
SELECT AVG(amount)
FROM payment;

-- Total payment
SELECT SUM(amount)
FROM payment;

-- Min, Max Payment
SELECT MIN(amount), MAX(amount)
FROM payment;

-- Find Total Payment for each Customer
SELECT c.customer_id, c.first_name || ' ' || c.last_name AS full_name, SUM(p.amount) AS total_amount
FROM customer c
JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY c.customer_id, full_name;

-- Show category name and total number of films in each category ordered by total descending.

SELECT 
 c.name, COUNT(fc.film_id) AS count
FROM film_category fc
JOIN category c
USING (category_id)
GROUP BY c.name;

-- Display city name and number of customers in each city.

SELECT c.city, COUNT(customer.customer_id) AS number_of_customer
FROM city c
JOIN address a
ON c.city_id = a.city_id
JOIN customer
ON customer.address_id = a.address_id
GROUP BY c.city_id;

-- Show staff name and total payment amount handled by each staff member.
SELECT s.first_name, SUM(p.amount)
FROM staff s
JOIN payment p
ON s.staff_id = p.staff_id
GROUP BY p.staff_id, s.first_name;

-- How many times films are rented
SELECT f.title, COUNT(*) AS total_rented
FROM film f
JOIN inventory i
USING (film_id)
JOIN rental r
USING (inventory_id)
GROUP BY f.title
HAVING COUNT(*) > 10;

-- Display customer names who made more than 30 rentals
SELECT c.customer_id, c.first_name ||' '||c.last_name AS full_name, COUNT(*) AS total_rental
FROM customer c
JOIN rental r
USING (customer_id)
GROUP BY c.customer_id
HAVING COUNT(*) > 30;

-- Show categories having more than 60 films.
SELECT c.name, COUNT(*) AS total_films
FROM category c
JOIN film_category fc
USING (category_id)
GROUP BY c.name
HAVING COUNT(*) > 60;

-- Display films with average rental rate per rating  greater than 2.
SELECT rating, AVG(rental_rate)
FROM film
GROUP BY rating
HAVING AVG(rental_rate) > 2
ORDER BY rating;

-- Show customers whose total payment is between 100 and 200.
SELECT c.customer_id, c.first_name || ' ' || c.last_name AS full_name, SUM(p.amount) AS total_payment
FROM customer c
JOIN payment p
USING (customer_id)
GROUP BY c.customer_id
HAVING SUM(p.amount) BETWEEN 100 AND 200;

-- One perticular category how many time rented
SELECT 
 c.name, COUNT(fc.film_id) AS rental_count
FROM film_category fc
JOIN category c
	USING (category_id)
JOIN film f
	USING (film_id)
JOIN inventory
	USING (film_id)
JOIN rental
	USING (inventory_id)
GROUP BY c.name;


-- One perticular category how many time not rented
SELECT 
 c.name, COUNT(fc.film_id) AS rental_count
FROM film_category fc
LEFT JOIN category c
	USING (category_id)
LEFT JOIN film f
	USING (film_id)
LEFT JOIN inventory
	USING (film_id)
LEFT JOIN rental
	USING (inventory_id)
where rental.rental_id IS NULL
GROUP BY c.name;

-- 19th Feb 2026

-- Show film ratings with average film length greater than 115 minutes.
SELECT rating, AVG(length) AS avg_length
FROM film
GROUP BY rating
HAVING AVG(length) > 115;

-- Display months (from payment_date) with total revenue greater than 5000.
SELECT EXTRACT(MONTH FROM payment_date), SUM(amount) AS total_revenu
FROM payment
GROUP BY EXTRACT (MONTH FROM payment_date)
HAVING SUM(amount) > 5000;	

-- Show top 5 customers by total payment.
SELECT c.customer_id, c.first_name ||' '|| c.last_name AS full_name, SUM(p.amount) AS total_payment
FROM customer c
JOIN payment p
	USING (customer_id)
GROUP BY c.customer_id
ORDER BY total_payment desc
LIMIT 5;

-- Show customers who rented films in more than 15 different categories.
SELECT c.customer_id, COUNT(DISTINCT fc.category_id) AS total_rented_films_by_categories
FROM customer c
JOIN rental r
	USING (customer_id)
JOIN inventory
	USING (inventory_id)
JOIN film f
	USING (film_id)
JOIN film_category fc
	USING (film_id)
GROUP BY c.customer_id
HAVING COUNT(DISTINCT fc.category_id) > 15
ORDER BY total_rented_films_by_categories desc;

-- Show customers who never made any payment.
SELECT c.customer_id, c.first_name || ' ' || c.last_name AS full_name
FROM customer c
JOIN payment p
	USING (customer_id)
WHERE p.customer_id IS NULL;

-- Display films that were never rented.
SELECT f.title
FROM film f
LEFT JOIN inventory i
	USING (film_id)
LEFT JOIN rental r
	USING (inventory_id)
WHERE r.inventory_id IS NULL;

-- Display films with total rental count greater than 10 ordered by rental count.
SELECT f.title, COUNT(*) AS rental_count
FROM film f
JOIN inventory i
	USING (film_id)
JOIN rental r
	USING (inventory_id)
GROUP BY f.title
HAVING COUNT(*) > 10
ORDER BY rental_count;

-- Display category with highest total revenue.
SELECT c.name, SUM(p.amount) AS total_revenue
FROM category c
JOIN film_category fc
	USING (category_id)
JOIN film f
	USING (film_id)
JOIN inventory i
	USING (film_id)
JOIN rental r
	USING (inventory_id)
JOIN payment p
	USING (rental_id)
GROUP BY c.name
ORDER BY total_revenue DESC 
	LIMIT 1;

-- Show top 3 most rented films.
SELECT f.title, COUNT(r.rental_id) AS total_rental
FROM category c
JOIN film_category fc
	USING (category_id)
JOIN film f
	USING (film_id)
JOIN inventory i
	USING (film_id)
JOIN rental r
	USING (inventory_id)
GROUP BY f.title
ORDER BY total_rental DESC
	LIMIT 3;

-- Display customers who rented films only from category 'Action'.
SELECT c.first_name || ' ' || c.last_name AS full_name
FROM customer c
JOIN rental r
	USING (customer_id)
JOIN inventory i
	USING (inventory_id)
JOIN film f
	USING (film_id)
JOIN film_category fc
	USING (film_id)
JOIN category ca
	USING (category_id)
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING 
    COUNT(DISTINCT ca.name) = 1
    AND MAX(ca.name) = 'Action';

-- Display cities where total payment revenue is greater than 10,000.
SELECT city.city, SUM(p.amount) AS total_revenu
FROM city city
JOIN address a
	USING (city_id)
JOIN customer c
	USING (address_id)
JOIN payment p
	USING (customer_id)
GROUP BY city.city
HAVING SUM(p.amount) > 10000;

-- Show film titles, category, total rentals and total revenue per film.
SELECT f.title, c.name, COUNT(r.rental_id) AS total_rentals, SUM(p.amount) AS total_revenue
FROM payment p
JOIN rental r
	USING (rental_id)
JOIN inventory i
	USING (inventory_id)
JOIN film f
	USING (film_id)
JOIN film_category fc
	USING (film_id)
JOIN category c
	USING (category_id)
GROUP BY f.title, c.name
ORDER BY total_revenue DESC;

-- Display customers, city, total rentals, total payment ordered by highest revenue.
SELECT 
	c.first_name || ' ' || c.last_name AS full_name, city.city, COUNT(r.rental_id) AS total_rental, SUM(p.amount) AS total_payment
FROM rental r
JOIN payment p
	USING (customer_id)
JOIN customer c
	USING (customer_id)
JOIN address a
	USING (address_id)
JOIN city
	USING (city_id)
GROUP BY c.first_name, c.last_name, city.city
ORDER BY total_payment DESC;

SELECT MAX(IN(2,