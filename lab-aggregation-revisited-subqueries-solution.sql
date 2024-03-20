use sakila;

## Select the first name, last name, and email address of all the customers who have rented a movie.
select * from rental;
select * from customer;

select c.first_name, c.last_name, r.customer_id, c.email
from rental r
join customer c on r.customer_id = c.customer_id;

## What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).
select * from customer; ## c.customer_id, c.first_name, c.last_name
select * from payment; ## p.customer_id, avg(p.amount)

select concat(c.customer_id, ' - ', c.first_name) as customer_id_name, avg(p.amount) as average_payment
from customer c
join payment p on c.customer_id = p.customer_id
group by  customer_id_name;




## Select the name and email address of all the customers who have rented the "Action" movies.
## Write the query using multiple join statements
## Write the query using sub queries with multiple WHERE clause and IN condition
## Verify if the above two queries produce the same results or not

select first_name, email
from customer
where 
    customer_id in (
        select 
            r.customer_id
        from 
            rental r
        where 
            r.inventory_id in (
                select 
                    i.inventory_id
                FROM 
                    inventory i
                where 
                    i.film_id in (
                        select 
                            f.film_id
                        from 
                            film f
                        join 
                            film_category fc on f.film_id = fc.film_id
                        join 
                            category cat on fc.category_id = cat.category_id
                        where 
                            cat.name = 'Action'
                    )
            )
    );
    
## Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment. 
## If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, the label should be medium, and if it is more than 4,
## then it should be high. 


select
    *,
    case
        when amount between 0 and 2 then 'low'
        when amount between 2 and 4 then 'medium'
        else 'high'
    end as transaction_label
from
    payment;
