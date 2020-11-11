
--- Lab | Stored procedures


-- 1

drop procedure if exists name_email_action;

delimiter //
create Procedure name_email_action()
begin
 select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = "Action"
  group by first_name, last_name, email;
end;
//
delimiter ;

call name_email_action();


-- 2

drop procedure if exists name_email_action2;

delimiter //
create procedure name_email_action2 (in param varchar(10))
begin
 select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name COLLATE utf8mb4_general_ci = param
  group by first_name, last_name, email;
end;
//
delimiter ;

call name_email_action2("Children");
call name_email_action2("Action");


-- 3

-- query : 
select name as category_name, count(film.film_id) as number_movie
from film, category, film_category 
where film.film_id=film_category.film_id 
and category.category_id=film_category.category_id
group by category_name ; 

-- procedures : 
drop procedure if exists number_movie_cat;

delimiter $$
create procedure number_movie_cat (in param1 int)
begin
  select name as category_name, count(film.film_id) as number_movie
from film, category, film_category 
where film.film_id=film_category.film_id 
and category.category_id=film_category.category_id
group by category_name
having count(film.film_id) COLLATE utf8mb4_general_ci > param1;
end $$
delimiter ;

call number_movie_cat(51);
