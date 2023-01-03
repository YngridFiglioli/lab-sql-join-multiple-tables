#Write a query to display for each store its store ID, city, and country.
#Write a query to display how much business, in dollars, each store brought in.
#What is the average running time of films by category?
#Which film categories are longest?
#Display the most frequently rented movies in descending order.
#List the top five genres in gross revenue in descending order.
#Is "Academy Dinosaur" available for rent from Store 1?

use sakila;
select s.store_id, ci.city, co.country from sakila.store s join address a
on s.address_id = a.address_id join city ci on a.city_id = ci.city_id join country co
on ci.country_id = co.country_id group by 1 order by 1;

select s.store_id, sum(p.amount) as b_amount from sakila.store s
join sakila.staff sf on s.store_id = sf.store_id
join sakila.payment p on sf.staff_id = p.staff_id group by 1 order by 1;

select c.name as category_name, round(avg(f.length), 2) as avg_time from film f
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id group by 1 order by 2 desc;

select f.title, count(r.rental_id) as top_title_rented from film f join inventory i on f.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id group by 1 order by 2 desc limit 1;

select c.name as category_name, sum(p.amount) as revenue from category c join film_category fc on c.category_id = fc.category_id
join film f on f.film_id = fc.film_id
join inventory i on f.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
join payment p on r.rental_id = p.rental_id group by 1 order by 2 desc limit 1;

select f.title as title, s.store_id as store, i.inventory_id as inven_id from inventory as i
join store as s on i.store_id=s.store_id
join film as f on f.film_id = i.film_id
where title = 'Academy Dinosaur' and s.store_id = 1;