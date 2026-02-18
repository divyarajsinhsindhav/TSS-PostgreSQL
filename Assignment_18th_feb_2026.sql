-- Display customer first name, last name and city.
SELECT c.first_name, c.last_name, city.city
FROM customer c
JOIN address a
ON c.address_id = a.address_id
JOIN city
ON a.city_id = city.city_id;

-- Show film title and category name ordered by category.
SELECT f.title, c.name
FROM film f
JOIN film_category fc
ON f.film_id = fc.film_id
JOIN category c
ON c.category_id = fc.category_id
ORDER BY c.name;

-- Display customer name and payment amount where amount between 5 and 10 ordered by amount descending.
SELECT c.first_name || ' ' || c.last_name AS customer_name, p.amount
FROM customer c
JOIN rental r
ON c.customer_id = r.customer_id
JOIN payment p
ON p.rental_id = r.rental_id
WHERE p.amount BETWEEN 5 AND 10
ORDER BY p.amount DESC;

-- Show films where rating IN ('PG','R') with category name ordered by rating.
SELECT f.title AS film_title, c.name AS category_name, f.rating AS rating
FROM film f
JOIN film_category fc
ON f.film_id = fc.film_id
JOIN category c
ON fc.category_id = c.category_id
WHERE f.rating IN('PG', 'R')
ORDER BY f.rating;

--  Display customer name and total number of rentals (use GROUP BY).
SELECT c.first_name || ' ' || c.last_name AS customer_name, COUNT(*) AS count_of_rental
FROM customer c
JOIN rental r
ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

-- Show category name and total number of films in each category ordered by total descending.
SELECT c.name, COUNT(*) AS count_of_film
FROM film f
JOIN film_category fc
ON f.film_id = fc.film_id
JOIN category c
ON c.category_id = fc.category_id
GROUP BY c.name
ORDER BY count_of_film DESC;
