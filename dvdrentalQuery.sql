-- SELECT * FROM actor;

-- select first_name, last_name from actor;

-- select first_name || ' ' || last_name  from actor;

-- select first_name || ' ' || last_name AS Full_Name  from actor;

-- select now();

-- select first_name ||' '|| last_name AS full_name from actor order by first_name, last_name asc;

-- select first_name ||' '|| last_name AS full_name from actor order by full_name desc;

-- select first_name ||' '|| last_name AS full_name from actor order by first_name desc, last_name asc;

-- select * from rental;

-- select distinct customer_id from rental;

-- select * from rental where rental_date BETWEEN '2005-05-01' AND '2005-06-01';

-- select * from rental where rental_date >= '2005-05-01' AND '2005-05-01' <= rental_date order by customer_id;

-- select * from rental where customer_id in (184, 185, 190, 1, 2) order by customer_id;

-- select * from rental where customer_id not in (184, 185, 190, 1, 2) order by customer_id;

-- select * from customer;

-- select * from customer where first_name = 'Jamie';

-- select * from customer where first_name = 'Adam' OR last_name = 'Rodriguez';

-- select * from customer where first_name LIKE '%an'

-- select * from customer where first_name LIKE 'A__'

-- select * from customer where first_name LIKE 'A%' AND LENGTH(first_name) BETWEEN 3 AND 7;

-- select * from customer where address_id > 20 AND create_date between '2006-01-01' AND '2006-06-30' order by create_date;

-- select * from customer where store_id IN(1,2) AND email IS NOT NULL;

-- select * from customer where first_name LIKE 'M%' AND LENGTH(first_name) BETWEEN 4 AND 6 AND activebool;

-- select * from customer where email IS NULL AND store_id = 1 AND activebool;

-- select * from customer where store_id not in(1,2,3) and activebool;

-- select * from customer order by create_date desc, first_name desc LIMIT 1 OFFSET 2;

-- select * from film;

-- select * from film order by film_id LIMIT 5;

-- select * from film order by film_id LIMIT 4 OFFSET 3;

-- select * from film order by rental_rate desc LIMIT 10;

-- select * from film
-- order by rental_rate desc
-- fetch first 10 rows only;

-- select customer.first_name ||' '|| customer.last_name AS full_name, rental.rental_id
-- from customer
-- LEFT JOIN rental ON customer.customer_id = rental.customer_id where rental.customer_id IS NULL;

SELECT f.title, 
       f.rental_rate, 
       l.name AS language_name
FROM film f
JOIN language l
ON l.language_id = f.language_id
WHERE f.rental_rate BETWEEN 0.99 AND 2.99;

SELECT r.rental_date,
       c.first_name || ' ' || c.last_name AS customer_name
FROM rental r
JOIN customer c
ON r.customer_id = c.customer_id
WHERE r.rental_date BETWEEN '2005-05-01' AND '2005-05-31'
ORDER BY r.rental_date;



