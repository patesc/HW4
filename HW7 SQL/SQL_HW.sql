USE sakila;

SELECT * FROM actor;

#1a.
SELECT * FROM actor WHERE last_name = 'CHASE';

#1b
ALTER TABLE actor
ADD COLUMN Actor_Name VARCHAR(100);
UPDATE actor SET Actor_Name = CONCAT(first_name, ' ', last_name);

#2a. Inserting Blob Column
ALTER TABLE actor
ADD COLUMN description BLOB(100);

#2b drop a column in actor
ALTER TABLE actor DROP description;

# Part 3a
SELECT actor_id, first_name, last_name FROM actor
WHERE first_name = "Joe";

# 3b
SELECT * FROM actor 
WHERE last_name LIKE '%GEN%';

# 3c
SELECT * FROM actor 
WHERE last_name LIKE '%LI%'
ORDER BY last_name, first_name;


#3d
SELECT country_id, country 
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

#4 
Use sakila;
Select last_name from actor;
SELECT last_name, COUNT(*)
    FROM actor
    GROUP BY last_name
    ORDER BY last_name;
 
Select * from actor;
UPDATE actor
SET first_name = 'HARPO'
WHERE actor_id = 172;
Select * from actor;
UPDATE actor
SET first_name = 'GROUCHO'
WHERE actor_id = 172;
Select * from actor;

SHOW CREATE TABLE actor;
CREATE TABLE `actor` (
  `actor_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`actor_id`),
  KEY `idx_actor_last_name` (`last_name`)
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8;
Select * from staff;

#6a
SELECT staff.first_name, staff.last_name, address.address
FROM staff
INNER JOIN address ON staff.address_id = address.address_id;

#6b
SELECT first_name, last_name, SUM(amount) FROM staff s
JOIN payment p
ON s.staff_id = p.staff_id
GROUP BY p.staff_id
ORDER BY last_name;

#6c
SELECT film_actor.film_id, film_actor.actor_id, film.title
FROM film
INNER JOIN film_actor ON film.film_id = film_actor.film_id;

#6d
Select * FROM film;

#6e

SELECT SUM(amount), first_name, last_name FROM customer c
	JOIN payment p
    ON p.customer_id = c.customer_id
    GROUP BY p.customer_id
	ORDER BY last_name;

# 7a
SELECT title FROM film
WHERE title LIKE 'K%' OR 'Q%' IN
 (
	SELECT language_id FROM Language
	WHERE name = 'English'
    );

#7b
Select * from film;
Select * from actor;
Select * from film_actor;
SELECT first_name, last_name
FROM actor
WHERE actor_id IN
(
 SELECT actor_id
 FROM film_actor
 WHERE film_id = 17
);


# 7c
SELECT first_name, last_name, email FROM customer WHERE address_id IN
(
SELECT address_id 
FROM address 
WHERE city_id IN
(
SELECT city_id 
FROM city 
WHERE country_id IN
(
SELECT country_id 
FROM country 
WHERE country = 'Canada')));


#7d
#sales lagging young families - target all family movies
#all movies categorized as _family_films
Select * from film;
Select * from film_category;
Select * from category;
SELECT title
FROM film
WHERE film_id IN
(
 SELECT film_id
 FROM film_category
 WHERE category_id =  8
);

#7e
SELECT COUNT(r.inventory_id), t.title, i.film_id AS 'Frequently_rented'
FROM inventory i
JOIN rental r
ON i.inventory_id = r.inventory_id
JOIN film_text t
ON i.film_id = t.film_id
GROUP BY r.inventory_id
ORDER BY Frequently_rented DESC, COUNT(r.inventory_id);

#7f
SELECT so.store_id, SUM(amount)
FROM store so
JOIN staff sa
ON so.store_id = sa.store_id
JOIN payment p
ON p.staff_id = sa.store_id
GROUP BY so.store_id
ORDER BY SUM(amount);

#7g
SELECT s.store_id, ci.city, co.country
FROM store s
JOIN address a
ON s.address_id = a.address_id
JOIN city ci
ON ci.city_id = a.city_id
JOIN country co
ON co.country_id = co.country_id;

#7h
SELECT SUM(p.amount), name
FROM category c
JOIN film_category fic
ON c.category_id = fic.category_id
JOIN inventory i
ON fic.film_id = i.film_id
JOIN rental r
ON i.inventory_id = r.inventory_id
JOIN payment p
ON r.rental_id = p.rental_id
GROUP BY name
ORDER BY (SUM(p.amount)) DESC
LIMIT 5;
#8a
CREATE VIEW top5 AS
SELECT SUM(p.amount), name
FROM category c
JOIN film_category fic
ON c.category_id = fic.category_id
JOIN inventory i
ON fic.film_id = i.film_id
JOIN rental r
ON i.inventory_id = r.inventory_id
JOIN payment p
ON r.rental_id = p.rental_id
GROUP BY name
ORDER BY (SUM(p.amount)) DESC
LIMIT 5;

#8b
SELECT * FROM top5;


#8c
DROP VIEW top5;






















