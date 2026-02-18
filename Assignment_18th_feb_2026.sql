-- Display customer first name, last name and city.
SELECT
	c.first_name,
	c.last_name,
	city.city
FROM
	customer c
	JOIN address a ON c.address_id = a.address_id
	JOIN city ON a.city_id = city.city_id;

-- Show film title and category name ordered by category.
SELECT
	f.title,
	c.name
FROM
	film f
	JOIN film_category fc ON f.film_id = fc.film_id
	JOIN category c ON c.category_id = fc.category_id
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
	AND staff_id IN (1, 2);

-- Display distinct film lengths where length between 80 and 120 AND rating IN ('PG-13','R') ordered by length.
SELECT DISTINCT
	LENGTH
FROM
	film
WHERE
	LENGTH BETWEEN 80 AND 120
	AND rating IN ('PG-13', 'R');

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
	LENGTH BETWEEN 60 AND 80
	OR rating = 'PG'
ORDER BY
	LENGTH;

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
