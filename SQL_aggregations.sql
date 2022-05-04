------------------
--SQL Aggregations
------------------

--Find the total amount of poster_qty paper and standard_qty paper ordered in the orders table. 

SELECT 
	SUM(poster_qty) AS total_poster,
	SUM(standard_qty) AS total_standard
FROM orders;


--Find the total dollar amount of sales using the total_amt_usd in the orders table.

SELECT 
	SUM(total_amt_usd) AS total_sales
FROM orders;


--Find the total amount for each individual order that was spent on standard and gloss paper in the orders table. 
--This should give a dollar amount for each order in the table.

SELECT 
	id, 
	standard_amt_usd + gloss_amt_usd AS total_amt_usd
FROM orders;


--Find the standard_amt_usd per unit of standard_qty paper (all of the sales made in the orders table).

SELECT 
	SUM(standard_amt_usd)/SUM(standard_qty) AS per_unit
FROM orders;


--When was the earliest order ever placed? You only need to return the date.

SELECT 
	MIN(occurred_at)
FROM orders;


--Try performing the same query as in question 1 without using an aggregation function

SELECT 
	occurred_at 
FROM orders 
ORDER BY occurred_at
LIMIT 1;


--When did the most recent (latest) web_event occur?

SELECT 
	MAX(occurred_at)
FROM web_events;


--Try to perform the result of the previous query without using an aggregation function

SELECT 
	occurred_at
FROM web_events
ORDER BY occurred_at DESC
LIMIT 1;


--Find the mean (AVERAGE) amount spent per order on each paper type, as well as the mean amount of each paper type purchased per order. 
--Your final answer should have 6 values - one for each paper type for the average number of sales, as well as the average amount.

SELECT 
	AVG(standard_qty) mean_standard, 
	AVG(gloss_qty) mean_gloss, 
	AVG(poster_qty) mean_poster, 
	AVG(standard_amt_usd) mean_standard_usd, 
	AVG(gloss_amt_usd) mean_gloss_usd, 
	AVG(poster_amt_usd) mean_poster_usd
FROM orders


--Which account (by name) placed the earliest order?
--Your solution should have the account name and the date of the order.

SELECT 
	a.name, 
	o.occurred_at
FROM accounts a
JOIN orders o
	ON a.id = o.account_id
ORDER BY occurred_at
LIMIT 1;


--Find the total sales in usd for each account. 
--You should include two columns - the total sales for each company's orders in usd and the company name.

SELECT 
	a.name, 
	SUM(total_amt_usd) total_sales
FROM accounts a 
JOIN orders o
	ON a.id = o.account_id
GROUP BY a.name;


--Via what channel did the most recent (latest) web_event occur, which account was associated with this web_event? 
--Your query should return only three values - the date, channel, and account name.

SELECT 
	w.occurred_at, 
	w.channel, 
	a.name
FROM web_events w
JOIN accounts a
	ON w.account_id = a.id 
ORDER BY w.occurred_at DESC
LIMIT 1;


--Find the total number of times each type of channel from the web_events was used. 
--Your final table should have two columns - the channel and the number of times the channel was used.

SELECT 
	w.channel, 
	COUNT(occurred_at) number_of_times
FROM web_events w
GROUP BY w.channel


--Who was the primary contact associated with the earliest web_event? 

SELECT 
	a.primary_poc
FROM web_events w
JOIN accounts a
	ON a.id = w.account_id
ORDER BY w.occurred_at
LIMIT 1;


--What was the smallest order placed by each account in terms of total usd. 
--Provide only two columns - the account name and the total usd. 
--Order from smallest dollar amounts to largest.

SELECT 
	a.name, 
	MIN(total_amt_usd) smallest_order
FROM accounts a
JOIN orders o
	ON a.id = o.account_id
GROUP BY a.name
ORDER BY smallest_order;


--Find the number of sales reps in each region. 
--Your final table should have two columns - the region and the number of sales_reps. 
--Order from fewest reps to most reps.

SELECT 
	r.name, 
	COUNT(s.name) num_reps
FROM region r
JOIN sales_reps s
	ON r.id = s.region_id
GROUP BY r.name
ORDER BY num_reps;


--For each account, determine the average amount of each type of paper they purchased across their orders. 
--Your result should have four columns - one for the account name and one for the average quantity purchased for each of the paper types for each account

SELECT 
	a.name, 
	AVG(o.standard_qty) avg_standard, 
	AVG(o.gloss_qty) avg_gloss, 
	AVG(o.poster_qty) avg_poster
FROM accounts a
JOIN orders o
	ON a.id = o.account_id
GROUP BY a.name


--Determine the number of times a particular channel was used in the web_events table for each sales rep. 
--Your final table should have three columns - the name of the sales rep, the channel, and the number of occurrences.
--Order your table with the highest number of occurrences first

SELECT 
	s.name, w.channel, 
	COUNT(*) num_occurrences
FROM accounts a
JOIN web_events w
	ON a.id = w.account_id
JOIN sales_reps s
	ON s.id = a.sales_rep_id
GROUP BY s.name, w.channel
ORDER BY num_occurrences DESC;


--Determine the number of times a particular channel was used in the web_events table for each region. 
--Your final table should have three columns - the region name, the channel, and the number of occurrences. 
--Order your table with the highest number of occurrences first.

SELECT 
	s.name, 
	w.channel, 
	COUNT(*) num_events
FROM accounts a
JOIN web_events w
	ON a.id = w.account_id
JOIN sales_reps s
	ON s.id = a.sales_rep_id
GROUP BY s.name, w.channel
ORDER BY num_events DESC;


--Determine the number of times a particular channel was used in the web_events table for each region. 
--Your final table should have three columns - the region name, the channel, and the number of occurrences. 
--Order your table with the highest number of occurrences first

SELECT 
	r.name, 
	w.channel, 
	COUNT(*) num_events
FROM accounts a
JOIN web_events w
	ON a.id = w.account_id
JOIN sales_reps s
	ON s.id = a.sales_rep_id
JOIN region r
	ON r.id = s.region_id
GROUP BY r.name, w.channel
ORDER BY num_events DESC;


--How many of the sales reps have more than 5 accounts that they manage?

SELECT 
	COUNT(*) num_reps
FROM(
	SELECT 
		s.name, 
		COUNT(a.id) num_accounts
     FROM accounts a
     JOIN sales_reps s
		ON s.id = a.sales_rep_id
     GROUP BY s.name
     HAVING COUNT(a.id) > 5
     ORDER BY num_accounts
) AS tab1;


--How many accounts have more than 20 orders?

SELECT
	COUNT(*) num_accounts
FROM(
	SELECT 
		a.name,  
		COUNT(o.id)
	FROM accounts a
	JOIN orders o
		ON a.id = o.account_id
	GROUP BY a.name
	HAVING COUNT(o.id) > 20
	ORDER BY COUNT(o.id)
) AS tab2;


--Which account has the most orders?

SELECT 
	a.name,  
	COUNT(o.id) num_orders
FROM accounts a
JOIN orders o
	ON a.id = o.account_id
GROUP BY a.name
HAVING COUNT(o.id) > 20
ORDER BY num_orders DESC
   LIMIT 1;


--Which accounts spent more than 30,000 usd total across all orders?

SELECT 
	a.name,  
	SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
	ON a.id = o.account_id
GROUP BY a.name
HAVING SUM(o.total_amt_usd) > 30000
ORDER BY total_spent DESC


--Which accounts spent less than 1,000 usd total across all orders?

SELECT 
	a.name,  
	SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
	ON a.id = o.account_id
GROUP BY a.name
HAVING SUM(o.total_amt_usd) < 1000
ORDER BY total_spent


--Which account has spent the most with us?

SELECT 
	a.name,  
	SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
	ON a.id = o.account_id
GROUP BY a.name
ORDER BY total_spent DESC
LIMIT 1;


--Which account has spent the least with us?

SELECT 
	a.name,  
	SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
	ON a.id = o.account_id
GROUP BY a.name
ORDER BY total_spent
LIMIT 1;


--Which accounts used facebook as a channel to contact customers more than 6 times?

SELECT 
	a.name, 
	w.channel,
	COUNT(w.occurred_at) use_channel
FROM accounts a
JOIN web_events w
	ON a.id = w.account_id
GROUP BY a.name, w.channel
HAVING COUNT(w.occurred_at) > 6 AND w.channel LIKE 'facebook'
ORDER BY use_channel DESC


--Which account used facebook most as a channel?

SELECT 
	a.name, 
	w.channel,
	COUNT(w.occurred_at) use_channel
FROM accounts a
JOIN web_events w
	ON a.id = w.account_id
GROUP BY a.name, w.channel
HAVING COUNT(w.occurred_at) > 6 AND w.channel LIKE 'facebook'
ORDER BY use_channel DESC
LIMIT 1;


--Which channel was most frequently used by most accounts?

SELECT 
	a.name, 
	w.channel, 
	COUNT(w.channel) use_channel
FROM accounts a
JOIN web_events w
	ON a.id = w.account_id
GROUP BY a.name, w.channel
ORDER BY use_channel DESC


--Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least. 
--Do you notice any trends in the yearly sales totals?

SELECT 
	DATE_TRUNC('year', occurred_at) year, 
	SUM(total_amt_usd) total_spent
FROM orders
GROUP BY DATE_TRUNC('year', occurred_at)
ORDER BY total_spent;


--Which month did Parch & Posey have the greatest sales in terms of total dollars? Are all months evenly represented by the dataset?

SELECT 
	DATE_TRUNC('month', occurred_at) month, 
	SUM(total_amt_usd) total_spent
FROM orders
GROUP BY DATE_TRUNC('month', occurred_at)
ORDER BY total_spent DESC


--Which year did Parch & Posey have the greatest sales in terms of total number of orders? Are all years evenly represented by the dataset?

SELECT 
	DATE_PART('year', occurred_at) year, 
	COUNT(*) total_sales
FROM orders
GROUP BY DATE_PART('year', occurred_at)
ORDER BY total_sales;


--In which month of which year did Walmart spend the most on gloss paper in terms of dollars?

SELECT 
	DATE_TRUNC('month', o.occurred_at) date, 
	SUM(o.gloss_amt_usd) total_spent
FROM orders o 
JOIN accounts a
	ON a.id = o.account_id
WHERE a.name = 'Walmart'
GROUP BY DATE_TRUNC('month', o.occurred_at)
ORDER BY total_spent DESC
LIMIT 1;

