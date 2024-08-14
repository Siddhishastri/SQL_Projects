create schema music_store;
--- Q1. Who is the senior most employee based on job title?
SELECT 
    *
FROM
    employee
ORDER BY levels DESC
LIMIT 1;

--- Q2. Which countries have the most invoices?
SELECT 
    COUNT(*) AS c, billing_country
FROM
    invoice
GROUP BY billing_country
ORDER BY c DESC;

--- Q3. What are top 3 values of total invoice
SELECT 
    total
FROM
    invoice
ORDER BY total DESC
LIMIT 3; 

--- Q4. which city has the best customer? we would like to throw a promotional music festival in 
--- the city we made the most money. write a query that returns one city has the highest sum of 
--- invoice totals. return both the city name & sum of all invoice totals

SELECT 
    SUM(total) AS invoice_total, billing_city
FROM
    invoice
GROUP BY billing_city
ORDER BY invoice_total DESC
LIMIT 2;

--- Q5. Who is the best customer? The customer who has spent the most money will be declared the 
--- best customer. Write a query that returns the person who has spent the most money

SELECT 
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    SUM(invoice.total) AS total
FROM
    customer
        JOIN
    invoice ON customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id
ORDER BY total DESC
LIMIT 1;

--- Q6. Write query to return the email, first name, last name, & genre of all rock music listeners
--- Return your list ordered alphabetically by email starting with A
SELECT DISTINCT
    email, first_name, last_name
FROM
    customer
        JOIN
    invoice ON customer.customer_id = invoice.invoice_id
        JOIN
    invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE
    track_id IN (SELECT 
            track_id
        FROM
            track
                JOIN
            genre ON track.genre_id = invoiceline.invoice_id
        WHERE
            genre.name LIKE 'Rock')
ORDER BY email;

--- Q7. Lets invite the artists who have written the most rock music in our dataset. Write a query
--- that returns the artist name and total track count of the top 10 rock bands 

SELECT 
    artist.artist_id,
    artist.name,
    COUNT(artist.artist_id) AS number_of_songs
FROM
    track
        JOIN
    album ON album.album_id = track.album_id
        JOIN
    artist ON artist.artist_id = album.artist_id
        JOIN
    genre ON genre.genre_id = track.genre_id
WHERE
    genre.name LIKE 'Rock'
GROUP BY artist.artist_id
ORDER BY number_of_songs DESC
LIMIT 10;

--- Q8. Return all the track names that have a song length longer than the average song length. Return the Name and 
--- Milliseconds for each track. Order by the song length with the longest songs listed first.

SELECT 
    name, milliseconds
FROM
    track
WHERE
    milliseconds > (SELECT 
            AVG(milliseconds) AS avg_track_length
        FROM
            track)
ORDER BY milliseconds DESC;

--- Q9. Find how much amount spent by each customers on artist? Write a query to return customer name,
--- artist name and total spent

with best_selling_artist as (SELECT 
    artist.artist_id AS artist_id,
    arist.name AS artist_name,
    SUM(invoice_line.unit_price * invoice_line.quantity) AS total_sales
FROM
    invoice_line
        JOIN
    track ON track.track_id = invoice_line.track_id
        JOIN
    album ON album.album_id = track.album_id
        JOIN
    artist ON artist.artist_id = album.artist_id
GROUP BY 1
ORDER BY 3 DESC
LIMIT 1)

SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    bsa.artist_name,
    SUM(il.unit_price * il.quantity) AS amount_spent
FROM
    invoice i
        JOIN
    customer c ON c.custometr_id = i.customer_id
        JOIN
    invoice_line il ON il.invoice_id = i.invoice_id
        JOIN
    track t ON t.track_id = il.track_id
        JOIN
    album alb ON alb.album_id = t.album_id
        JOIN
    best_selling_artist bsa ON bsa.artist_id = alb.artist_id
GROUP BY 1 , 2 , 3 , 4
ORDER BY 5 DESC;

--- Q10. We want to find out the most popular music genre for each country
--- (We determine the most popular genre as the genre with the highest amouunt of purchases)

With popular_genre as
(
select count(invoice_line.quality) as purchases, customer.country, genre.name, genre.genre_id,
row_number() over(partition by customer.country order by count(invoice_line.quantity) desc) as RowNo
from invoice_line
join invoice on invoice.invoice_id = invoice_line.invoice_id
join customer on customer.customer_id = invoice.customer_id
join track on track.track_id = invoice_line.track_id
join genre on genre.genre_id = track.genre_id
group by 2,3,4
order by 2 ASC, 1 desc
)
select * from popular_genre where RowNo <= 1;

--- Q11. Write a query that determines the customer that has spent the most on music for each 
--- country. Write a query that returns the country along with the top customer and how much they 
--- spent. For countries where the top amount spent is shared, provide all customers who spent 
--- this amount

with Customer_with_country as (
select customer.customer_id,first_name,last_name,billing_country,sum(total) as total_spending,
row_number() over(partition by billing_country order by sum(total) desc) as RowNo
from invoice
join customer on customer.customer_id = invoice.customer_id
group by 1,2,3,4
order by 4 ASC, 5 desc)
select * from Customer_with_Country WHERE RowNo <= 1;






