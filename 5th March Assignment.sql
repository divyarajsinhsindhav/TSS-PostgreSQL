CREATE OR REPLACE FUNCTION get_customer_rental_summary(p_customer_id INT)
RETURNS TABLE(
    total_rentals INT,
    total_amount NUMERIC
)
LANGUAGE plpgsql
AS
$$
DECLARE
    rental_cursor CURSOR FOR
        SELECT 
            r.rental_id,
            f.title,
            r.rental_date,
            r.return_date,
            COALESCE(p.amount,0) AS amount
        FROM rental r
        JOIN inventory i ON r.inventory_id = i.inventory_id
        JOIN film f ON i.film_id = f.film_id
        LEFT JOIN payment p ON r.rental_id = p.rental_id
        WHERE r.customer_id = p_customer_id;

    rec RECORD;

    v_total_rentals INT := 0;
    v_total_amount NUMERIC := 0;
BEGIN

    OPEN rental_cursor;

    LOOP
        FETCH rental_cursor INTO rec;
        EXIT WHEN NOT FOUND;

        RAISE NOTICE 'Rental ID: %, Film: %, Rental Date: %, Return Date: %',
            rec.rental_id,
            rec.title,
            rec.rental_date,
            rec.return_date;

        v_total_rentals := v_total_rentals + 1;
        v_total_amount := v_total_amount + rec.amount;

    END LOOP;

    CLOSE rental_cursor;

    RETURN QUERY
    SELECT v_total_rentals, v_total_amount;

END;
$$;