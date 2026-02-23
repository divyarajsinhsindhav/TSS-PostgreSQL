-- find out all films that have been rented more than average times of all films
SELECT f.title, COUNT(r.rental_id)
FROM film f
JOIN inventory i
	USING (film_id)
JOIN rental r
	USING (inventory_id)
GROUP BY f.title
HAVING COUNT(r.rental_id) > (
	SELECT AVG(rental_count) FROM (
		SELECT COUNT(r.rental_id) AS rental_count
			FROM film f
		JOIN inventory i
			USING (film_id)
		JOIN rental r
			USING (inventory_id)
		GROUP BY f.title 
	)
);


-- Display customers who live in the same city as customer with ID = 1.
SELECT cu.*, ci.city
FROM customer cu
JOIN address a
	USING (address_id)
JOIN city ci
	USING (city_id)
WHERE ci.city = (
    SELECT ci2.city
    FROM customer cu2
    JOIN address a2 
		USING (address_id)
    JOIN city ci2
		USING (city_id)
    WHERE cu2.customer_id = 1
);

-- Display films whose rental rate is higher than the average rental rate of all films.
SELECT *
FROM film
WHERE rental_rate > (
    SELECT AVG(rental_rate)
    FROM film
);

-- Show customers whose total payment is greater than the average total payment of all customers.
SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_payment
FROM customer c
JOIN payment p USING(customer_id)
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(p.amount) > (
    SELECT AVG(total)
    FROM (
        SELECT SUM(amount) AS total
        FROM payment
        GROUP BY customer_id
    ) AS sub
);

-- Show films that belong to the same category as the film titled 'Alien Center'.
SELECT f.title, c.name
FROM film f
JOIN film_category fc 
	USING(film_id)
JOIN category c 
	USING(category_id)
WHERE c.category_id = (
    SELECT fc2.category_id
    FROM film f2
    JOIN film_category fc2 
		USING(film_id)
    WHERE f2.title = 'Alien Center'
);

-- Display actors who acted in films that are longer than 120 minutes.
SELECT DISTINCT a.actor_id, a.first_name, a.last_name
FROM actor a
JOIN film_actor fa 
	USING(actor_id)
JOIN film f 
	USING(film_id)
WHERE f.length > 120;




