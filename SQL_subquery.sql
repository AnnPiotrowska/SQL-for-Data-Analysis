--------------
--SQL Subquery
--------------

/*
We want to find the average number of events for each day for each channel. 
The first table will provide us the number of events for each day and channel, 
and then we will need to average these values together using a second query.
*/

--find the number of events that occur for each day for each channel

SELECT 
	DATE_TURNC('day', occurred_at) day,
	channel,
	COUNT(*) event_count
FROM web_events
GROUP BY 1,2
ORDER BY 1;


--now find the average number of events for each channel

SELECT 
	channel,
	AVG(event_count) AS avg_event_count
FROM
	(SELECT 
		DATE_TRUNC('day', occurred_at) day,
		channel,
		COUNT(*) event_count
	FROM web_events
	GROUP BY 1,2
	) tab1
GROUP BY 1
ORDER BY 2 DESC;

/*
On which day-channel pair did the most events occur?
*/

SELECT 
	day,
    channel,
	AVG(event_count) AS avg_event_count
FROM
	(SELECT 
		DATE_TRUNC('day', occurred_at) AS day,
		channel,
		COUNT(*) event_count
	FROM web_events
	GROUP BY 1,2			
	) tab1
GROUP BY 2,1
ORDER BY 3 DESC;


/*
We want to return only orders that occurred in the same month as Parch and Posies first order ever.
*/

SELECT *
FROM orders
WHERE DATE_TRUNC('month', occurred_at) = 
	(SELECT 
		DATE_TRUNC('month',MIN(occurred_at)) min_month
	FROM orders)
ORDER BY occurred_at;


/*
Find only the orders that took place in the same month as Parch and Posies first order ever and pull the average for each type of paper qty in this month.
*/

SELECT 
	AVG(standard_qty) avg_std,
    AVG(gloss_qty) avg_gls, 
    AVG(poster_qty) avg_pst
FROM orders
WHERE DATE_TRUNC('month', occurred_at) =
	(SELECT 
		DATE_TRUNC('month',MIN(occurred_at)) min_month
	FROM orders);
	

/*
Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales
*/

SELECT 
	region_name,
	MAX(sum_total) max_total
FROM(SELECT 
		s.name rep_name, 
		r.name region_name,
		SUM(total_amt_usd) sum_total
	FROM accounts a
	JOIN sales_reps s
		ON s.id = a.sales_rep_id
	JOIN orders o
		ON a.id = o.account_id
	JOIN region r
		ON r.id = s.region_id
	GROUP BY 2,1
	) tab1
GROUP BY 1;